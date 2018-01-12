Received: from eggs.gnu.org ([2001:4830:134:3::10]:50624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZxwf-0004Xv-Nn
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:56:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZxwe-0001Zr-D9
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:56:25 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-6-vsementsov@virtuozzo.com>
	<dd58d0a5-3838-5ef7-cb8b-0b74e5e22d27@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0e1fe4e6-f496-4891-c428-e43b8d09887c@virtuozzo.com>
Date: Fri, 12 Jan 2018 14:56:13 +0300
MIME-Version: 1.0
In-Reply-To: <dd58d0a5-3838-5ef7-cb8b-0b74e5e22d27@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 5/6] iotests: implement
 QemuIoInteractive class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

09.01.2018 23:34, Eric Blake wrote:
> On 12/07/2017 09:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>
> The subject says what, but there is no commit body that says why.
>
> Presumably this makes writing the test in the next patch easier, but
> some details in the commit message would make this obvious.
>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/iotests.py | 38 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
> My python is not strong; it looks good overall, although I have a few
> questions that may warrant a v3 before I give R-b.
>
>> +class QemuIoInteractive:
>> +    def __init__(self, *args):
>> +        self.args = qemu_io_args + list(args)
>> +        self._p = subprocess.Popen(self.args, stdin=subprocess.PIPE,
>> +                                   stdout=subprocess.PIPE,
>> +                                   stderr=subprocess.STDOUT)
> Why STDOUT instead of STDERR?  Is the redirection intentional?

this special flag means: "send subprocess stderr to the same place as 
stdout", so,
I'll have both stdout and stderr in one .PIPE. I don't print these 
outputs, but return
them to the user.

>
>
>> +    def _read_output(self):
>> +        pattern = 'qemu-io> '
>> +        n = len(pattern)
>> +        pos = 0
>> +        s = []
>> +        while pos != n:
>> +            c = self._p.stdout.read(1)
>> +            #check unexpected EOF
> pep8 doesn't like this comment style (it wants space after #).  The file
> is already unclean under pep8, but you shouldn't make it worse.
>
>> +            assert c != ''
> Is assert really the nicest control flow when early EOF is present? Or
> is it because we are only using this in tests, where we don't expect
> early EOF, so asserting is just fine for our usage?

The only usage for now is a test in the following patch. I think assert 
is OK for now,
we can change it in future if needed.

>
>> +            s.append(c)
>> +            if c == pattern[pos]:
>> +                pos += 1
>> +            else:
>> +                pos = 0
>> +
>> +        return ''.join(s[:-n])
> Is it necessary to use join() on the empty string here, compared to just
> returning the array slice directly?

It seems more usual for such function to return string, not a list. 
Without join here,
I'll have to join in caller.

>


-- 
Best regards,
Vladimir

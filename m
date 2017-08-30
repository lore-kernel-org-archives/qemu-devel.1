Received: from eggs.gnu.org ([2001:4830:134:3::10]:55599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnBMl-000871-59
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnBMj-0008Qu-Ta
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:21:43 -0400
References: <cover.1504111803.git.jcody@redhat.com>
	<aea3a5d63b6937d8bd87afb3741db6c09ea7436e.1504111803.git.jcody@redhat.com>
	<627b615e-b42d-f59c-7b9f-e02fd139a85b@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4c0570ce-8632-dcbc-86d5-a84be57ce0d7@redhat.com>
Date: Wed, 30 Aug 2017 18:21:32 -0400
MIME-Version: 1.0
In-Reply-To: <627b615e-b42d-f59c-7b9f-e02fd139a85b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/5] qemu-iotests: add 'blind_remove'
 for python tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org



On 08/30/2017 02:13 PM, Eric Blake wrote:
> On 08/30/2017 11:52 AM, Jeff Cody wrote:
>> Add a function to attempt to 'blindly' remove a file, without
>> throwing an error if the file doesn't exist.
>>
>> Signed-off-by: Jeff Cody <jcody@redhat.com>
>> ---
>>  tests/qemu-iotests/iotests.py | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
>> index 7233983..a2088c7 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -57,6 +57,13 @@ qemu_default_machine = os.environ.get('QEMU_DEFAULT_MACHINE')
>>  socket_scm_helper = os.environ.get('SOCKET_SCM_HELPER', 'socket_scm_helper')
>>  debug = False
>>  
>> +def blind_remove(filename):
>> +    try:
>> +        os.remove(filename)
>> +    except OSError, error:
> 
> I'm assuming this works for both python 2 and 3?
> 

Appears to be python2 specific syntax, actually. using "as error"
appears to work in both 2.7 and 3.whatever, and according to
http://python3porting.com/differences.html will work in 2.6 too.

>> +        if error.errno != errno.ENOENT:
>> +            raise
>> +
> 
> Weak, since I'm not the strongest at python, but you can add:
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

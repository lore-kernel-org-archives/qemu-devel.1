Received: from eggs.gnu.org ([209.51.188.92]:50650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqPj-0003Xb-2x
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:25:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqPf-00077h-Gn
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:25:22 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:34614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gvqPb-0006zF-A4
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:25:15 -0500
Received: by mail-wm1-f50.google.com with SMTP id y185so696142wmd.1
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 13:25:14 -0800 (PST)
References: <1550519997-253534-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<2cbb158f-a869-e24c-96cc-23f7f61a946b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4f992059-b448-a234-d319-3eb3bb5e04c9@redhat.com>
Date: Mon, 18 Feb 2019 22:25:12 +0100
MIME-Version: 1.0
In-Reply-To: <2cbb158f-a869-e24c-96cc-23f7f61a946b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests: handle TypeError for Python3 in
 test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, Eduardo Habkost <ehabkost@redhat.com>, mreitz@redhat.com

On 2/18/19 9:05 PM, Eric Blake wrote:
> [adding Eduardo for some python 2-vs-3 advice]

And Cleber.

> 
> On 2/18/19 1:59 PM, Andrey Shinkevich wrote:
>> To write one byte to disk, Python2 may use 'chr' type.
>> In Python3, conversion to 'byte' type is required.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>  tests/qemu-iotests/242 | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
>> index 16c65ed..6b1f7b8 100755
>> --- a/tests/qemu-iotests/242
>> +++ b/tests/qemu-iotests/242
>> @@ -65,9 +65,14 @@ def toggle_flag(offset):
>>      with open(disk, "r+b") as f:
>>          f.seek(offset, 0)
>>          c = f.read(1)
>> -        toggled = chr(ord(c) ^ bitmap_flag_unknown)
>> +        toggled = ord(c) ^ bitmap_flag_unknown
>>          f.seek(-1, 1)
>> -        f.write(toggled)
>> +        try:
>> +            # python2
>> +            f.write(chr(toggled))
>> +        except TypeError:
>> +            # python3
>> +            f.write(bytes([toggled]))
> 
> Looks like it works, but I'm not enough of a python expert to know if
> there is a more Pythonic elegant approach.
> 
> If someone else picks it up before my next NBD pull request,
> Acked-by: Eric Blake <eblake@redhat.com>
> 

Received: from eggs.gnu.org ([209.51.188.92]:41765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gwyXo-0005cx-KN
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 19:18:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gwyXn-0008D6-Kb
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 19:18:24 -0500
References: <1550519997-253534-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<2cbb158f-a869-e24c-96cc-23f7f61a946b@redhat.com>
	<4f992059-b448-a234-d319-3eb3bb5e04c9@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <dbd04ea0-6a60-9817-52b3-a0cc73f1a637@redhat.com>
Date: Thu, 21 Feb 2019 19:17:56 -0500
MIME-Version: 1.0
In-Reply-To: <4f992059-b448-a234-d319-3eb3bb5e04c9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, Eduardo Habkost <ehabkost@redhat.com>, mreitz@redhat.com



On 2/18/19 4:25 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/18/19 9:05 PM, Eric Blake wrote:
>> [adding Eduardo for some python 2-vs-3 advice]
>=20
> And Cleber.
>=20
>>
>> On 2/18/19 1:59 PM, Andrey Shinkevich wrote:
>>> To write one byte to disk, Python2 may use 'chr' type.
>>> In Python3, conversion to 'byte' type is required.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>  tests/qemu-iotests/242 | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
>>> index 16c65ed..6b1f7b8 100755
>>> --- a/tests/qemu-iotests/242
>>> +++ b/tests/qemu-iotests/242
>>> @@ -65,9 +65,14 @@ def toggle_flag(offset):
>>>      with open(disk, "r+b") as f:
>>>          f.seek(offset, 0)
>>>          c =3D f.read(1)
>>> -        toggled =3D chr(ord(c) ^ bitmap_flag_unknown)
>>> +        toggled =3D ord(c) ^ bitmap_flag_unknown
>>>          f.seek(-1, 1)
>>> -        f.write(toggled)
>>> +        try:
>>> +            # python2
>>> +            f.write(chr(toggled))
>>> +        except TypeError:
>>> +            # python3
>>> +            f.write(bytes([toggled]))
>>
>> Looks like it works, but I'm not enough of a python expert to know if
>> there is a more Pythonic elegant approach.
>>

Well, there's no way around the fact that bytes in Python 3 are very
different from bytes in Python 2 (just another name for a string).

What I'd recommend here is to not base the type on the exception, but
choose it depending on the Python version.  Something like:

if sys.version_info.major =3D=3D 2:
   f.write(chr(toggled))
else:
   f.write(bytes([toggled])]

This is cheaper than raising/catching exceptions, it's self documenting,
and follows the pattern on other tests.

Regards,
- Cleber.

>> If someone else picks it up before my next NBD pull request,
>> Acked-by: Eric Blake <eblake@redhat.com>
>>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e1VuM-00055C-Cd
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e1VuI-0005vR-BP
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:07:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e1VuI-0005v3-2J
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:07:34 -0400
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-3-pasic@linux.vnet.ibm.com>
	<d6d2d73d-65c9-7ae1-fd37-cb8e304781e7@redhat.com>
	<7f454872-fae3-35b0-eff4-227b2aa0f77d@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6c17b274-cd75-7864-94b9-fc8abff1a786@redhat.com>
Date: Mon, 9 Oct 2017 13:07:27 +0200
MIME-Version: 1.0
In-Reply-To: <7f454872-fae3-35b0-eff4-227b2aa0f77d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/8] s390x/css: IO instr handler ending
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On 09.10.2017 12:54, Halil Pasic wrote:
>=20
>=20
> On 10/09/2017 10:20 AM, Thomas Huth wrote:
>> On 04.10.2017 17:41, Halil Pasic wrote:
>>> CSS code needs to tell the IO instruction handlers located in how sho=
uld
>>
>> located in how?
>>
>=20
> First, thanks for your review!
>=20
> Wanted to say: in target/s390x/ioinst.c just forgot to copy paste.
>=20
>>> the emulated instruction be ended. Currently this is done by returnin=
g
>>> generic (POSIX) error codes, and mapping them to outcomes like condit=
ion
>>> codes. This makes bugs easy to create and hard to recognise.
>>>
>>> As a preparation for moving a way form (mis)using generic error codes=
 for
>>> flow control let us introduce a struct which tells the instruction
>>> handler function how to end the instruction, in a more straight-forwa=
rd
>>> and less ambiguous way.
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> ---
>>>  include/hw/s390x/css.h | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
>>> index 0653d3c9be..66916b6546 100644
>>> --- a/include/hw/s390x/css.h
>>> +++ b/include/hw/s390x/css.h
>>> @@ -75,6 +75,18 @@ typedef struct CMBE {
>>>      uint32_t reserved[7];
>>>  } QEMU_PACKED CMBE;
>>> =20
>>> +/* IO instructions conclude according this */
>>> +typedef struct IOInstEnding {
>>> +        /*
>>> +         * General semantic of cc codes of IO instructions is (brief=
):
>>> +         * 0 -- produced expected result
>>> +         * 1 --  status conditions were present or produced alternat=
e result
>>> +         * 2 -- ineffective, because busy with previously initiated =
function
>>> +         * 3 -- ineffective, not operational
>>> +         */
>>> +        int cc;
>>> +} IOInstEnding;
>>
>> Why do you need a struct for this? Do you plan to extend it later? If
>> so, I think you should mention that in the patch description. If not,
>> please use a named enum or a "typedef unsigned int IOInstEnding" inste=
ad.
>>
>>  Thomas
>=20
> We may, we may not. In the previous version we also had to support
> do end a certain instruction with an addressing exception, but this
> is going away in patch #3. Honestly I don't expect this being extended.
>=20
> I have other reasons for the struct. Type safety and clear semantics,
> and frankly at least for s390 and linux I don't see any downsides given
> what is written in the "zSeries ELF Application Binary Interface Supple=
ment".
> Can you please explain to me what is the problem with using this struct=
, and
> what is the benefit switching to a unsigned int?

First, returning a struct is ugly in most cases, since it might need to
be passed on the stack if it is bigger than 8 bytes. Ok, that's likely
not the case here (if the compiler / ABI is smart enough - I did not
check), but still, if I see something like this, there is an alarm
signal somewhere in my head that starts to ring...

Then, in the follow up patches, you do something like this:

   return (IOInstEnding){.cc =3D 0};

... and that just looks very, very ugly in my eyes. The more I look at
it, the more I think we really want to have a named enum instead. That
will give you some sort of basic type safety and semantics, too, and
we'll also get proper names for those magic values - otherwise I'll
always have to look up what cc =3D 2 or cc =3D 3 means... (I always keep
forgetting what each value means...)

 Thomas

Received: from eggs.gnu.org ([209.51.188.92]:48283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gjOFR-0003AG-8q
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 07:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gjOFQ-0002Qi-7w
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 07:55:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gjOFP-0002QE-Vo
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 07:55:16 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-10-fli@suse.com>
	<87a7kcml5i.fsf@dusky.pond.sub.org>
	<f5631b6b-d313-88dc-f80a-890c26f109e4@126.com>
	<878sznquv6.fsf@dusky.pond.sub.org>
	<8504f713-0334-62b2-c462-4bdcb3c83caf@126.com>
Date: Tue, 15 Jan 2019 13:55:12 +0100
In-Reply-To: <8504f713-0334-62b2-c462-4bdcb3c83caf@126.com> (Fei Li's message
	of "Mon, 14 Jan 2019 21:38:46 +0800")
Message-ID: <871s5ejd1r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 09/16] qemu_thread: supplement
 error handling for pci_edu_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>
Cc: Jiri Slaby <jslaby@suse.cz>, qemu-devel@nongnu.org, shirley17fei@gmail.com

Fei Li <lifei1214@126.com> writes:

> =E5=9C=A8 2019/1/14 =E4=B8=8B=E5=8D=888:36, Markus Armbruster =E5=86=99=
=E9=81=93:
>> Fei Li <lifei1214@126.com> writes:
>>
>>> Just to make sure about how to do the cleanup. I notice that in device_=
set_realized(),
>>> the current code does not call "dc->unrealize(dev, NULL);" when dc->rea=
lize() fails.
> Sorry that I am still uncertain.. I guess the code below I pasted was
> misleading,
> actually I want to stress the *dc->unrealize() is not called when
> dc->realize() fails*
> and the incomplete below "goto fail" does not include the dc->unrealize(),
> but instead the dc->unrealize() is included in later
> child_realize_fail: & post_realize_fail:.
>
>
> Emm, IMHO, I think when dc->realize() fails, the dc->unrealize() is
> either should be
> called in the common function: device_set_realized() in a unified way,
> that is
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err !=3D NULL) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dc->unrealize=
) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dc->unrealize(dev, local_err);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto f=
ail;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> or do the unrealize() locally for each device earlier when
> dc->realize() fails.
>
> But I checked several dc->realize() function, they did not call unrealize=
()
> when fails. Besides, it may mean verbose code if unrealize() locally.
> Thus I think the above way is the right way to do the cleanup when
> realize() fails.

The realize() method is specified to either succeed completely or fail
completely, i.e. fail and do nothing.  The "either succeed completely or
fail completely" aspect of the specification is sane and perfectly
ordinary.

How a concrete implementation accomplishes "fail completely" is up to
the implementation.

An implementation may choose to structure its FOO_realize() and
FOO_unrealize() in a way that lets FOO_realize() call FOO_unrealize() to
clean up on failure.

An implementation may also choose to clean up differently.

This freedom of choice is by design.

Changing the specification now would involve auditing and updating all
realize() and unrealize() methods.  Not going to happen without an
extremely compelling reason.

>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dc->realize) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc-=
>realize(dev, &local_err);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err !=3D NULL) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o fail;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> Is this on purpose? (Maybe due to some devices' realize() do their own =
cleanup
>>> when fails? Sorry for the unsure, it is such a common function that I d=
id not
>>> check all. :( ) Or else, I prefer to do the cleanup in a unified manner=
, e.g. call "dc->unrealize(dev, NULL);" which is the pci_qdev_unrealize() f=
or pci devices.
>> Yes, this is on purpose.
>>
>> When a realize() method fails, it must revert everything it has done so
>> far.  Results in sane "either succeed completely, or fail and do
>> nothing" semantics.
>
> Have a nice day, thanks
>
> Fei

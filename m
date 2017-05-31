Received: from eggs.gnu.org ([2001:4830:134:3::10]:40780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG3bH-0003jx-KP
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG3bD-0008Jk-G9
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:23:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dG3bD-0008Je-Ao
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:23:43 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-15-marcandre.lureau@redhat.com>
	<871srmqq46.fsf@dusky.pond.sub.org>
	<CAJ+F1CJ8K=i_nZex49Gm7SMs4bPHyw_U_HZ0GNiQaAch9GwtrQ@mail.gmail.com>
Date: Wed, 31 May 2017 15:23:40 +0200
In-Reply-To: <CAJ+F1CJ8K=i_nZex49Gm7SMs4bPHyw_U_HZ0GNiQaAch9GwtrQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 31 May 2017
	11:10:45 +0000")
Message-ID: <87efv588ir.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 14/17] acpi: fix s3/s4 disabled type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> On Thu, May 18, 2017 at 4:58 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Use a more specific bool type.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Why doesn't this run afoul backward compatibility?  To answer the
>> question, we need to enumerate affected external interfaces.
>>
>>
> Right, this will break if we have users such as:
>
>  -global PIIX4_PM.disable_s3=3D2
>
> With this change, it will now error with:
>
> qemu-system-x86_64: can't apply global PIIX4_PM.disable_s3=3D2: Invalid
> parameter type for 'disable_s3', expected: boolean
>
> Acceptable? otherwise, I drop the patch

Quick grep through libvirt... aha, src/qemu_command.c:

    if (def->pm.s3) {
        const char *pm_object =3D "PIIX4_PM";

        if (qemuDomainIsQ35(def) &&
            virQEMUCapsGet(qemuCaps, QEMU_CAPS_ICH9_DISABLE_S3)) {
            pm_object =3D "ICH9-LPC";
        } else if (!virQEMUCapsGet(qemuCaps, QEMU_CAPS_PIIX_DISABLE_S3)) {
            virReportError(VIR_ERR_CONFIG_UNSUPPORTED,
                           "%s", _("setting ACPI S3 not supported"));
            return -1;
        }

        virCommandAddArg(cmd, "-global");
        virCommandAddArgFormat(cmd, "%s.disable_s3=3D%d",
                               pm_object, def->pm.s3 =3D=3D VIR_TRISTATE_BO=
OL_NO);
    }

We need to keep at least disable_s3=3D0 and disable_s3=3D1 working.  Let's
drop the patch from this series.

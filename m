Received: from eggs.gnu.org ([2001:4830:134:3::10]:51811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evkkN-0003jG-NH
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evkkM-0001kk-JH
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:17:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evkkM-0001kB-Ag
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:17:46 -0400
References: <20180312183628.394722-1-eblake@redhat.com>
	<CAFEAcA9HLfz77eEHho+Vod=XSsvoNv10noFJjqoAd0=CXT-8dQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ad8cb727-8e0d-d2ba-659e-9b91f59c30cd@redhat.com>
Date: Tue, 13 Mar 2018 09:17:36 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9HLfz77eEHho+Vod=XSsvoNv10noFJjqoAd0=CXT-8dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/36] QAPI patches for 2018-03-12,
 2.12 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>

On 03/13/2018 09:02 AM, Peter Maydell wrote:
> On 12 March 2018 at 18:35, Eric Blake <eblake@redhat.com> wrote:
>> The following changes since commit 6ceb1b51f05f9e1892d082960ed602dca7b=
6696e:
>>
>>    Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180312-pu=
ll-request' into staging (2018-03-12 16:14:37 +0000)
>>
>> are available in the Git repository at:
>>
>>    git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-12
>>
>> for you to fetch changes up to a083c533b5a17c77ef164acdbf30eedfa9681fc=
6:
>>
>>    qapi: add block latency histogram interface (2018-03-12 13:22:11 -0=
500)
>>
>> This builds and passes 'make check', so even though the OOB portion
>> depends on chardev fixes that are still pending a pull request from
>> Paolo, that dependence can only be observed at runtime by clients
>> that use the new oob feature.  Given the timing of soft freeze, and
>> the fact that the chardev fixes do not form a build dependency, I
>> think it's okay if this pull request gets processed before Paolo's
>> (but it's also okay if Paolo's goes in first).

Based on the testsuite failures, it looks like Paolo's pull request with=20
chardev fixes DOES have to go in first. More at [1] below.

> x86/Linux and x86 OpenBSD, compile failure (probably gcc-version-depend=
ent):
>=20
> /home/petmay01/linaro/qemu-for-merges/hw/i386/acpi-build.c: In
> function =E2=80=98build_append_pci_bus_devices=E2=80=99:
> /home/petmay01/linaro/qemu-for-merges/hw/i386/acpi-build.c:617:9:
> error: =E2=80=98notify_method=E2=80=99 may be used uninitialized in thi=
s function
> [-Werror=3Dmaybe-uninitialized]
>           aml_append(parent_scope, notify_method);
>           ^
> /home/petmay01/linaro/qemu-for-merges/hw/i386/acpi-build.c:510:16:
> note: =E2=80=98notify_method=E2=80=99 was declared here
>       Aml *dev, *notify_method, *method;
>                  ^
> cc1: all warnings being treated as errors

Odd - The only mention of notify_method in that file in my series is in=20
the context:

$ git diff 6ceb1b51f..pull-qapi-2018-03-12 hw/i386/acpi-build.c \
    |grep notify_method
          notify_method =3D aml_method("DVNT", 2, AML_NOTSERIALIZED);

and where all the hunks look like:

@@ -154,21 +154,21 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
      /* Fill in optional s3/s4 related properties */
      o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NU=
LL);
      if (o) {
-        pm->s3_disabled =3D qnum_get_uint(qobject_to_qnum(o));
+        pm->s3_disabled =3D qnum_get_uint(qobject_to(QNum, o));

which doesn't change control flow logic.  So all I can guess is that=20
this has been a latent pre-existing problem, but the compiler is now=20
flagging it.  At any rate, I can try and shut it up, and will spin a v2=20
once the other issue is solved.


>=20
> on PPC64 Linux, FreeBSD x86, OpenBSD x86, aarch64 Linux hosts, test fai=
ls;
> looks like the same assert but in different tests:
>=20
> ppc64:
> TEST: tests/qmp-test... (pid=3D48041)
>    /alpha/qmp/protocol:                                                =
 OK
>    /alpha/qmp/oob:                                                     =
 OK
>    /alpha/qmp/query-status:                                            =
 OK
>    /alpha/qmp/query-block:
> qemu-system-alpha: /home/pm215/qemu/
> chardev/char-io.c:91: io_watch_poll_finalize: Assertion `iwp->src =3D=3D
> ((void *)0)' failed.
> Broken pipe
> FAIL
> GTester: last random seed: R02S3e793887202ca8b099adb20531a072e6
> (pid=3D48057)
>=20

[1] this is probably the chardev fixes being tickled by oob.  (Weird=20
that the change is not failing the oob test, though - or is the failure=20
happening during cleanup of the oob test, AFTER it reported OK?)  Here's=20
where I'm hoping Paolo's pull request with chardev fixes is the=20
solution, otherwise, I may have to disable Peter's OOB patches.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

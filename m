Received: from eggs.gnu.org ([2001:4830:134:3::10]:53574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWQhY-00059a-Md
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWQhV-0003s5-FG
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:45:40 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485164923-17736-1-git-send-email-armbru@redhat.com>
	<1485164923-17736-7-git-send-email-armbru@redhat.com>
	<2fd376cd-e88a-b6da-d648-b80d35e74c7a@redhat.com>
	<877f5l1tak.fsf@dusky.pond.sub.org>
	<3512807d-d04e-50fa-9fcf-d1d5ba8ac350@redhat.com>
	<87r33saa6p.fsf@dusky.pond.sub.org>
Date: Wed, 25 Jan 2017 17:45:27 +0100
In-Reply-To: <87r33saa6p.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 24 Jan 2017 13:56:14 +0100")
Message-ID: <87vat33x7c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 6/6] hw/i386/i386: Stop auto-creating
 lsi53c895a SCSI HBAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kwolf@redhat.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>

David, Alex, got a sPAPR question for you.

Markus Armbruster <armbru@redhat.com> writes:

> Cc'ing in sPAPR maintainers...
[...]
> Let me spell things out a bit more, to make sure we all agree on what
> exactly we want to deprecate.
>
> After this series, -drive if=scsi works for the following machine types:
>
> * magnum pica61 LX SPARCClassic SPARCbook SS-10 SS-20 SS-4 SS-5 SS-600MP
>   Voyager
>
>   The machine has an onboard SCSI HBA, which adopts the drives with
>   bus=0..  Drives with non-zero bus numbers stay orphaned.  This is
>   exactly how other interface types work.
>
>   Except when additional HBAs get cold-plugged somehow, non-zero bus
>   numbers can work; see below.
>
> * realview-eb realview-eb-mpcore versatileab versatilepb
>
>   These create N lsi53c895a SCSI HBAs, where N is the largest value of
>   bus.  If N is too large, machine initialization fails with a "no
>   slot/function available for lsi53c895a, all in use" error.
>
>   This is just like the PC machine types work before this patch.
>
> * pseries-*
>
>   Likewise, except create spapr-vscsi SCSI HBAs.  Large N make machine
>   initialization s-l-o-w.  I tried to find out whether and how it fails
>   when N is too large, but I lost patience.

Totally unscientific experiment: run "qemu-system-ppc64 -S -display none
-monitor stdio -M pseries,accel=qtest -drive if=scsi,media=cdrom,bus=N"
for various N and check SZ in ps, with "ps -C qemu-system-ppc64 -O sz".
Results:

      N      SZ
      0  339413
     10  353182
     20  375342
     30  405857
     40  444716
     50  491988
     60  547582
     70  611589
     80  683916
     90  764658
    100  853743

Definitely super-linear.  Is this expected?

No wonder my previous bus=999 experiement thrashed my machine;
extrapolating from the above I guesstimate SZ in the order of 50 million
pages.

Of course, asking for 1000 spapr-vscsi devices is silly, but trashing is
not a nice way to say "don't be silly".  Should we reject bus=N when N
exceeds a certain limit?  Care to suggest a limit?

[...]

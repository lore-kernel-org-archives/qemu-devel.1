Received: from eggs.gnu.org ([2001:4830:134:3::10]:36936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cmJqh-0005qJ-2q
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 07:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cmJqc-0008PJ-8M
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 07:40:47 -0500
Message-ID: <1489149636.3805.38.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Fri, 10 Mar 2017 13:40:36 +0100
In-Reply-To: <87e06501-0df6-8c02-e9c4-01ce8d52cd85@redhat.com>
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
	<1485868319-16151-3-git-send-email-thuth@redhat.com>
	<20170303145807.GC11509@thinpad.lan.raisama.net>
	<87e06501-0df6-8c02-e9c4-01ce8d52cd85@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: Print CPU help after we've
 registered the CPU accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>

On Tue, 2017-03-07 at 10:02 +0100, Thomas Huth wrote:
> The problem is that on POWER, we've got a "family" of CPUs with
> different sub-types, e.g. for POWER8:
>=C2=A0
> $ qemu-system-ppc64 -cpu ? | grep POWER8
> PowerPC POWER8E_v2.1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PVR 004b0201
> PowerPC POWER8E=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0(alias for POWER8E_v2.1)
> PowerPC POWER8NVL_v1.0=C2=A0=C2=A0=C2=A0PVR 004c0100
> PowerPC POWER8NVL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(alias=
 for POWER8NVL_v1.0)
> PowerPC POWER8_v2.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PVR 004d0200
> PowerPC POWER8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0(alias for POWER8_v2.0)
>=C2=A0
> Most of the users don't know about the current subtype that they are
> using, and just want to use "-cpu POWER8" - and for example we've also
> got an agreement with the libvirt folks that they can always use "-cpu
> POWER8" for any kind of POWER8 system, no matter whether the host is
> using a POWER8E or POWER8NVL chip.

Yup, thanks for bringing that up and keeping an eye out
to make sure it keeps working :)

> So the "POWER8" alias now gets updated internally in QEMU to the correc=
t
> host CPU type ... but the output of "-cpu help" is then still wrong.
> I agree that it's kind of ugly to have different help texts depending o=
n
> whether "accel=3Dkvm" has been used or not, but that sounds still bette=
r
> to me than printing wrong information here.
> Thinking about this again ... maybe it would be better if we'd rework
> the help text to print out something like this instead:
>=C2=A0
> PowerPC POWER8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0(alias for any POWER8 chip)
>=C2=A0
> ... so that we simply get rid of the version/subtype information here
> completely?

I was initially concerned about this, because I remembered
libvirt parsing the string after "(alias for ", but I
checked and it looks like we do so only for machine types,
not for CPU models.

So the change should be safe, and since we're using QMP to
fetch CPU definitions these days, I don't expect we'll need
to worry about this change even in the future.

Still, did you try changing the description and using the
resulting QEMU binary along with libvirt?

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization

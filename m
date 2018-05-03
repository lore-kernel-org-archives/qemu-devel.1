Received: from eggs.gnu.org ([2001:4830:134:3::10]:33384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fECWR-0007Cm-Dg
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fECWO-0005vj-9u
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:35:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48630 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fECWO-0005vd-4c
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:35:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B57D542BDF15
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 11:35:35 +0000 (UTC)
Date: Thu, 3 May 2018 13:35:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180503133533.15b8a677@redhat.com>
In-Reply-To: <20180501150723.GF32129@redhat.com>
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
	<1524841523-95513-4-git-send-email-imammedo@redhat.com>
	<20180501150723.GF32129@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 03/11] cli: add --preconfig option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, ehabkost@redhat.com, armbru@redhat.com

On Tue, 1 May 2018 16:07:23 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Apr 27, 2018 at 05:05:15PM +0200, Igor Mammedov wrote:
> > This option allows pausing QEMU in the new RUN_STATE_PRECONFIG state,
> > allowing the configuration of QEMU from QMP before the machine jumps
> > into board initialization code of machine_run_board_init()
> >=20
> > The intent is to allow management to query machine state and additional=
ly
> > configure it using previous query results within one QEMU instance
> > (i.e. eliminate the need to start QEMU twice, 1st to query board specif=
ic
> > parameters and 2nd for actual VM start using query results for
> > additional parameters).
> >=20
> > The new option complements -S option and could be used with or without
> > it. The difference is that -S pauses QEMU when the machine is completely
> > initialized with all devices wired up and ready to execute guest code
> > (QEMU needs only to unpause VCPUs to let guest execute its code),
> > while the "preconfig" option pauses QEMU early before board specific in=
it
> > callback (machine_run_board_init) is executed and allows the configurat=
ion
> > of machine parameters which will be used by board init code. =20
>=20
> > When early introspection/configuration is done, command 'exit-preconfig'
> > should be used to exit RUN_STATE_PRECONFIG and transition to the next
> > requested state (i.e. if -S is used then QEMU will pause the second
> > time when board/device initialization is completed or start guest
> > execution if -S isn't provided on CLI) =20
>=20
> If we're going to introduce this --preconfig facility I would very much
> like us to ensure that we do *not* need to continue to also use -S. IOW
> it would be nice to essentially consider --preconfig a better impl of
> -S and stop using -S, perhaps even deprecating it for removal.
That's how I view this as well,
modulo removal of -S option as it still might be used for hotplugging and
for early VM startup dubugging and other thing that really need ready
to run machine.

> What logical things does QEMU do after exiting pre-config stage, but
> before starting CPUs that might be dependency for mgmt apps that would
> neccessitate using both --preconfig and -S ?
I've replied to your other email listing them, so lets figure
out the plan of what needs to be fixed so that libvirt could
switch from -S to --preconfig only.
PS:
(Since I've started this whole thing, I'm willing to work on
gradually improving it)

> Regards,
> Daniel

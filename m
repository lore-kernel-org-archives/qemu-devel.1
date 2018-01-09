Received: from eggs.gnu.org ([2001:4830:134:3::10]:42530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ahino@redhat.com>) id 1eZ0WE-0004M5-G5
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:29:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ahino@redhat.com>) id 1eZ0WA-0005X2-7B
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:29:10 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:41342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ahino@redhat.com>) id 1eZ0WA-0005WH-1E
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:29:06 -0500
Received: by mail-vk0-f52.google.com with SMTP id v70so10215389vkd.8
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 12:29:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1c03b655-a0b5-d043-1c19-6050e1930633@redhat.com>
References: <20180105065538.13375-1-famz@redhat.com>
	<20180108144136.GF8052@localhost.localdomain>
	<CAMr-obsaegU2HDaH3EFoD+2EYUnPKuqsvQPk4GZ7hTdqXmpoWA@mail.gmail.com>
	<20180108175729.GI8052@localhost.localdomain>
	<20180109062425.GA18346@lemon.usersys.redhat.com>
	<20180109095825.GB6063@localhost.localdomain>
	<CAPuOgO35suw3LN4H0PZoE3ap+xZvK3tERvCHSUfHDMKc7-5XfQ@mail.gmail.com>
	<1c03b655-a0b5-d043-1c19-6050e1930633@redhat.com>
From: Ala Hino <ahino@redhat.com>
Date: Tue, 9 Jan 2018 22:29:04 +0200
Message-ID: <CAPuOgO1pOL5V_gFW64XT6oE1mnsVinkN2pCikdKom8mvvkmyVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] qemu-img: Let "info" warn
 and go ahead without -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Nir Soffer <nirsof@gmail.com>, Max Reitz <mreitz@redhat.com>

On Tue, Jan 9, 2018 at 10:11 PM, Eric Blake <eblake@redhat.com> wrote:

> On 01/09/2018 01:58 PM, Ala Hino wrote:
>
> >>> I know this is debatable but I think the #1 purpose of image locking is
> >> to
> >>> prevent data corruption;
> >>
> >> Isn't potentially wrong output of 'qemu-img info' a form of data
> >> corruption? Not data as in disk content, but metadata is data, too.
> >>
> >>> #2 IMO is to reduce confusion and misinformation.
> >>> While inconsistent output of "qemu-img info" is misinformation, it not
> >> working
> >>> as before is actually confusion. Though the current behavior is indeed
> >> ideal,
> >>> the proposed patch is a bit more pragmatical.
> >>
> >> To be clear: If we want to minimise confusing by change, we have to
> >> disable locking by default, not only here but everywhere else. And
> >> therefore make it completely useless.
> >>
> >> The whole point of locking is to change something in order to make
> >> things safer. Yes, this may inconvenience users who want to do something
> >> unsafe. Tough luck. The only other option is not making things safer.
> >>
> >
> > Safer is better for sure.
> > It is not about doing something unsafe, it is about breaking a released
> > version -
> > RHV 4.1 is already out and when customers upgrade to RHEL 7.5, they will
> not
> > be able to create snapshots.
> > I see two options:
> > 1. As mentioned by Fam, settle on warning for good
>
> Which is a downgrade in qemu behavior, since we've already had releases
> where it was an error (and if you have to worry about THOSE qemu
> releases, then the warning doesn't buy you anything).
>

We test our code on RHEL, and currently require qemu-kvm-rhev >= 2.6.0.
On RHEL 7.4 qemu-kvm-rhev version is 2.9.0 - and everything works good.
However, on RHEL 7.5 the version is 2.10.0, which breaks RHV 4.1.
If we got qemu-kvm-rhev 2.10.0 in RHEL 7.4 repositories, we could detect the
failure earlier and maybe we would be able to adapt the code before
releasing 4.1.

>
> > 2. Conflict qemu with vdsm < 4.2
>
> If I'm understanding this option correctly, you are proposing that the
> distribution is set up so that you have to upgrade vdsm prior to being
> able to upgrade to newer qemu that enables locking (so you can use old
> vdsm, old qemu; new vdsm, old qemu; new vdsm, new qemu; but you get
> rejected on attempts to use old vdsm, new qemu).  That's outside the
> scope of qemu proper and falls instead into the distro's packaging
> scheme, but sounds like a better alternative than trying to fix new qemu
> to work around an issue that released qemu already has, all on behalf of
> vdsm where old vdsm plays nice with old qemu, and where new vdsm already
> knows how to play nice with both flavors of qemu.
>

I agree that this might be the better option.

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
>

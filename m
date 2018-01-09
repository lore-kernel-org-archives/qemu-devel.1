Received: from eggs.gnu.org ([2001:4830:134:3::10]:52339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ahino@redhat.com>) id 1eZ033-0004kS-Un
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:59:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ahino@redhat.com>) id 1eZ030-0002uN-Da
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:59:02 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ahino@redhat.com>) id 1eZ030-0002sz-8e
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:58:58 -0500
Received: by mail-vk0-f41.google.com with SMTP id w22so1725681vkw.0
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 11:58:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180109095825.GB6063@localhost.localdomain>
References: <20180105065538.13375-1-famz@redhat.com>
	<20180108144136.GF8052@localhost.localdomain>
	<CAMr-obsaegU2HDaH3EFoD+2EYUnPKuqsvQPk4GZ7hTdqXmpoWA@mail.gmail.com>
	<20180108175729.GI8052@localhost.localdomain>
	<20180109062425.GA18346@lemon.usersys.redhat.com>
	<20180109095825.GB6063@localhost.localdomain>
From: Ala Hino <ahino@redhat.com>
Date: Tue, 9 Jan 2018 21:58:55 +0200
Message-ID: <CAPuOgO35suw3LN4H0PZoE3ap+xZvK3tERvCHSUfHDMKc7-5XfQ@mail.gmail.com>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, Jan 9, 2018 at 11:58 AM, Kevin Wolf <kwolf@redhat.com> wrote:

> Am 09.01.2018 um 07:24 hat Fam Zheng geschrieben:
> > On Mon, 01/08 18:57, Kevin Wolf wrote:
> > > I'm not sure if going back to the old behaviour for a while now would
> be
> > > helpful, you'd just end up with an even more confusing set of qemu
> > > versions, for example:
> > >
> > >     <= 2.9          - works without a warning
> > >     2.10 and 2.11   - errors out
> > >     2.12            - prints a warning, but works
> > >     >= 2.13         - errors out again
> >
> > What I had in mind is settle on warning for good. QEMU (including
> qemu-img) is a
> > low level tool that can be used in many ways that it isn't supposed to,
> this one
> > is not more harmful than others (e.g. "qemu-img snapshot ..." on
> iscsi:// qcow2
> > image) we allow siliently.
> >
> > I know this is debatable but I think the #1 purpose of image locking is
> to
> > prevent data corruption;
>
> Isn't potentially wrong output of 'qemu-img info' a form of data
> corruption? Not data as in disk content, but metadata is data, too.
>
> > #2 IMO is to reduce confusion and misinformation.
> > While inconsistent output of "qemu-img info" is misinformation, it not
> working
> > as before is actually confusion. Though the current behavior is indeed
> ideal,
> > the proposed patch is a bit more pragmatical.
>
> To be clear: If we want to minimise confusing by change, we have to
> disable locking by default, not only here but everywhere else. And
> therefore make it completely useless.
>
> The whole point of locking is to change something in order to make
> things safer. Yes, this may inconvenience users who want to do something
> unsafe. Tough luck. The only other option is not making things safer.
>

Safer is better for sure.
It is not about doing something unsafe, it is about breaking a released
version -
RHV 4.1 is already out and when customers upgrade to RHEL 7.5, they will not
be able to create snapshots.
I see two options:
1. As mentioned by Fam, settle on warning for good
2. Conflict qemu with vdsm < 4.2

>
> We already successfully made a point that tools (libvirt with shared
> images, or libguestfs) need to update their qemu invocation for qemu
> proper. They didn't like it, but they could see the point, and it has
> been this way for two releases already. So I don't see a compelling
> reason why now we should give up again some of the safety we achieved
> long-term.
>
> If we were designing qemu-img from scratch, it would be an error. So
> that's what it should be in the long term. Tools should preferably use
> 'query-block' and friends rather 'qemu-img info' if the image is in use.
>
> Kevin
>

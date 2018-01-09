Received: from eggs.gnu.org ([2001:4830:134:3::10]:34173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eYqg6-0004zI-8H
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 04:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eYqg5-0005ny-7Z
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 04:58:42 -0500
Date: Tue, 9 Jan 2018 10:58:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180109095825.GB6063@localhost.localdomain>
References: <20180105065538.13375-1-famz@redhat.com>
	<20180108144136.GF8052@localhost.localdomain>
	<CAMr-obsaegU2HDaH3EFoD+2EYUnPKuqsvQPk4GZ7hTdqXmpoWA@mail.gmail.com>
	<20180108175729.GI8052@localhost.localdomain>
	<20180109062425.GA18346@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109062425.GA18346@lemon.usersys.redhat.com>
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
To: Fam Zheng <famz@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Ala Hino <ahino@redhat.com>

Am 09.01.2018 um 07:24 hat Fam Zheng geschrieben:
> On Mon, 01/08 18:57, Kevin Wolf wrote:
> > I'm not sure if going back to the old behaviour for a while now would be
> > helpful, you'd just end up with an even more confusing set of qemu
> > versions, for example:
> > 
> >     <= 2.9          - works without a warning
> >     2.10 and 2.11   - errors out
> >     2.12            - prints a warning, but works
> >     >= 2.13         - errors out again
> 
> What I had in mind is settle on warning for good. QEMU (including qemu-img) is a
> low level tool that can be used in many ways that it isn't supposed to, this one
> is not more harmful than others (e.g. "qemu-img snapshot ..." on iscsi:// qcow2
> image) we allow siliently.
> 
> I know this is debatable but I think the #1 purpose of image locking is to
> prevent data corruption;

Isn't potentially wrong output of 'qemu-img info' a form of data
corruption? Not data as in disk content, but metadata is data, too.

> #2 IMO is to reduce confusion and misinformation.
> While inconsistent output of "qemu-img info" is misinformation, it not working
> as before is actually confusion. Though the current behavior is indeed ideal,
> the proposed patch is a bit more pragmatical.

To be clear: If we want to minimise confusing by change, we have to
disable locking by default, not only here but everywhere else. And
therefore make it completely useless.

The whole point of locking is to change something in order to make
things safer. Yes, this may inconvenience users who want to do something
unsafe. Tough luck. The only other option is not making things safer.

We already successfully made a point that tools (libvirt with shared
images, or libguestfs) need to update their qemu invocation for qemu
proper. They didn't like it, but they could see the point, and it has
been this way for two releases already. So I don't see a compelling
reason why now we should give up again some of the safety we achieved
long-term.

If we were designing qemu-img from scratch, it would be an error. So
that's what it should be in the long term. Tools should preferably use
'query-block' and friends rather 'qemu-img info' if the image is in use.

Kevin

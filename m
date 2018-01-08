Received: from eggs.gnu.org ([2001:4830:134:3::10]:54295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1eYauB-0007ae-0J
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1eYau6-0000rr-HU
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:08:10 -0500
MIME-Version: 1.0
References: <20180105065538.13375-1-famz@redhat.com>
	<20180108144136.GF8052@localhost.localdomain>
In-Reply-To: <20180108144136.GF8052@localhost.localdomain>
From: Nir Soffer <nirsof@gmail.com>
Date: Mon, 08 Jan 2018 17:07:54 +0000
Message-ID: <CAMr-obsaegU2HDaH3EFoD+2EYUnPKuqsvQPk4GZ7hTdqXmpoWA@mail.gmail.com>
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
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Ala Hino <ahino@redhat.com>

On Mon, Jan 8, 2018 at 4:48 PM Kevin Wolf <kwolf@redhat.com> wrote:

> Am 05.01.2018 um 07:55 hat Fam Zheng geschrieben:
> > Management and users are accustomed to "qemu-img info" to query status of
> > images even when they are used by guests. Since image locking was added,
> the -U
> > (--force-share) option is needed for that to work. The reason has been
> that due
> > to possible race with image header update, the output can be misleading.
> >
> > But what are likely to happen after we emit the error are that, for
> interactive
> > users, '-U' will be used and the command retried; for management (nova,
> RHV,
> > etc.), the operation is broken with no knob to workaround this.
> >
> > This series changes that error to a warning so that it doesn't get in
> the way.
>
> Are management tools actually doing this? There is no good reason to
> call 'qemu-img info' for an image that is in use by a VM.
>

Yes, ovirt/RHV is using this to get the qcow2 compat of an image since 4.1.

We asked about this here and in private mail, and there was an agreement
that
using qemu-img info on an image is safe for this purpose. We know that
accessing
image header when a guest is using is may be racy, but we control both the
guest
and the image. Nobody is modifying the image properties behind our back.

In 4.2 we will use the new flags[1], but  we cannot fix released code.
Introducing
this locking in qemu-img info will break existing installations.


> If no, NACK. Automatically disabling locking because it can be
> inconvenient defeats the purpose of locking.
>
> If yes, clearly indicate that this usage is deprecated and we'll turn
> this into an error again with 2.13. Then management tools can be fixed
> in time.


This will work for us in general, but I'm not sure that when 2.13 will be
released,
no user will run code assuming the previous behavior. It will be best to
wait with
incompatible changes like this to next major version.

[1] https://gerrit.ovirt.org/85874/

Nir

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX1be-0008C6-GP
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX1bd-0004QR-Ax
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:42:18 -0400
Date: Mon, 17 Jul 2017 10:42:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170717084205.GB5301@noname.redhat.com>
References: <CAPuOgO2q9nNtoPOYuXSWDxBVVsXcWEMbMboLT4OdpXA_Dq5O=Q@mail.gmail.com>
	<7a891962-9c57-7668-e2fd-69e5e13b9078@redhat.com>
	<CAMr-obtga00C5cKS63T_5RW99hK2W1nKMDba4cnTGH8dVYrXaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMr-obtga00C5cKS63T_5RW99hK2W1nKMDba4cnTGH8dVYrXaA@mail.gmail.com>
Subject: Re: [Qemu-devel] Supporting unsafe create when backing file is not
 accessible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Ala Hino <ahino@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-discuss@nongnu.org, Nir Soffer <nsoffer@redhat.com>, John Snow Huston <jsnow@redhat.com>

Am 14.07.2017 um 21:13 hat Nir Soffer geschrieben:
> On Wed, Jul 12, 2017 at 5:40 PM Eric Blake <eblake@redhat.com> wrote:
> 
> > On 07/12/2017 03:56 AM, Ala Hino wrote:
> > > Hi,
> > >
> > > We encountered a performance issue when creating a volume for a running
> > VM
> > > and we'd like to share the info with you. The root cause of the issue is
> > in
> > > our code but we found a workaround that relies on qemu-img create
> > > undocumented behavior.
> > >
> > > During our tests, we found that in order to create a volume with a
> > backing
> > > file, the baking file has to be valid and accessible.
> >
> > In general, that's a good thing. But you're also right that it is nice
> > to have a mode where the backing file is not probed.
> >
> > > This requires us to
> > > activate the entire chain before creating the volume, and deactivate the
> > > chain after the operation completes. Activating and deactivating the
> > chain
> > > are expensive operations that we prefer to avoid when possible. Below is
> > > the command we use to create volumes:
> > >
> > > qemu-img create -f qcow2 -o compat=1.1 -b
> > > 8a28cda2-548d-47da-bbba-faa81284f6ba -F raw
> > >
> > /rhev/data-center/e6b272af-84cb-43fc-ae5b-7fe18bc469a2/f47c980a-fd76-44a9-8b78-00d3ab2ffd2f/images/2ff0a3c0-f145-4f83-b668-fc0c39ba191f/d3b69657-892f-499c-9ac3-9c443ead7d9b
> > > 1073741824
> > >
> > > We also found that when providing the size and the backing format for
> > qemu,
> > > qemu doesn't open the backing chain, and in this case we don't have to
> > > activate/deactivate the entire chain - exactly the behavior we wish to
> > have.
> >
> > Yes, that is currently the case. You are correct that patches have been
> > proposed to tighten things so that we would probe the existence of the
> > backing file in more cases (even when the size is provided); and that if
> > we do so, we'd also have to provide a backdoor for creating an image
> > without probing the backing file.  But it is also the case that you can
> > create an image with NO backing file, and then use 'qemu-img rebase -u'
> > to add the backing file after the fact, without waiting for any proposed
> > patches to land.
> >
> > > We we'd like to get your confirmation of the above behavior as it isn't
> > > documented, and whether it can be documented.
> >
> > The fact that you are asking does mean that we should revive John's
> > proposed patches, in some form or another.
> >
> 
> Eric, we are more concerned about using the current qemu version.
> 
> We can use the fact that providing both size and backing format,
> qemu does not open the backing file, but this is not documented, and
> we don't want to base oVirt code on undocumented behavior.
> 
> What we would like to have is:
> - qemu blessing for using this undocumented behaviour
> - and documenting this behavior in qemu-img(1)

You already asked me whether you could rely on this behaviour in a
private email and my answer was a pretty clear no.

I'm not sure what you're hoping to get from asking someone else for the
same thing, but if you want an accurate answer, it won't change.

We won't document this undocumented behaviour because it isn't
intentional in the first place. It is simply a missing check of user
input in qemu-img.

> With this we can fix https://bugzilla.redhat.com/1395941
> <https://bugzilla.redhat.com/show_bug.cgi?id=1395941>
> now, instead of waiting for qemu 2.10.

Upstream doesn't compromise on interfaces to make life more convenient
for downstreams. The correct procedure here is to get a -u added for
2.10 and then backport it into the downstream.

Kevin

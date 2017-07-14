Received: from eggs.gnu.org ([2001:4830:134:3::10]:55564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1dW623-0006h2-91
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 15:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1dW621-0004Zs-D7
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 15:13:43 -0400
MIME-Version: 1.0
References: <CAPuOgO2q9nNtoPOYuXSWDxBVVsXcWEMbMboLT4OdpXA_Dq5O=Q@mail.gmail.com>
	<7a891962-9c57-7668-e2fd-69e5e13b9078@redhat.com>
In-Reply-To: <7a891962-9c57-7668-e2fd-69e5e13b9078@redhat.com>
From: Nir Soffer <nirsof@gmail.com>
Date: Fri, 14 Jul 2017 19:13:24 +0000
Message-ID: <CAMr-obtga00C5cKS63T_5RW99hK2W1nKMDba4cnTGH8dVYrXaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eric Blake <eblake@redhat.com>, Ala Hino <ahino@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>, John Snow Huston <jsnow@redhat.com>

On Wed, Jul 12, 2017 at 5:40 PM Eric Blake <eblake@redhat.com> wrote:

> On 07/12/2017 03:56 AM, Ala Hino wrote:
> > Hi,
> >
> > We encountered a performance issue when creating a volume for a running
> VM
> > and we'd like to share the info with you. The root cause of the issue is
> in
> > our code but we found a workaround that relies on qemu-img create
> > undocumented behavior.
> >
> > During our tests, we found that in order to create a volume with a
> backing
> > file, the baking file has to be valid and accessible.
>
> In general, that's a good thing. But you're also right that it is nice
> to have a mode where the backing file is not probed.
>
> > This requires us to
> > activate the entire chain before creating the volume, and deactivate the
> > chain after the operation completes. Activating and deactivating the
> chain
> > are expensive operations that we prefer to avoid when possible. Below is
> > the command we use to create volumes:
> >
> > qemu-img create -f qcow2 -o compat=1.1 -b
> > 8a28cda2-548d-47da-bbba-faa81284f6ba -F raw
> >
> /rhev/data-center/e6b272af-84cb-43fc-ae5b-7fe18bc469a2/f47c980a-fd76-44a9-8b78-00d3ab2ffd2f/images/2ff0a3c0-f145-4f83-b668-fc0c39ba191f/d3b69657-892f-499c-9ac3-9c443ead7d9b
> > 1073741824
> >
> > We also found that when providing the size and the backing format for
> qemu,
> > qemu doesn't open the backing chain, and in this case we don't have to
> > activate/deactivate the entire chain - exactly the behavior we wish to
> have.
>
> Yes, that is currently the case. You are correct that patches have been
> proposed to tighten things so that we would probe the existence of the
> backing file in more cases (even when the size is provided); and that if
> we do so, we'd also have to provide a backdoor for creating an image
> without probing the backing file.  But it is also the case that you can
> create an image with NO backing file, and then use 'qemu-img rebase -u'
> to add the backing file after the fact, without waiting for any proposed
> patches to land.
>
> > We we'd like to get your confirmation of the above behavior as it isn't
> > documented, and whether it can be documented.
>
> The fact that you are asking does mean that we should revive John's
> proposed patches, in some form or another.
>

Eric, we are more concerned about using the current qemu version.

We can use the fact that providing both size and backing format,
qemu does not open the backing file, but this is not documented, and
we don't want to base oVirt code on undocumented behavior.

What we would like to have is:
- qemu blessing for using this undocumented behaviour
- and documenting this behavior in qemu-img(1)

With this we can fix https://bugzilla.redhat.com/1395941
<https://bugzilla.redhat.com/show_bug.cgi?id=1395941>
now, instead of waiting for qemu 2.10.

For future version, having a explicit way to allow unsafe create
is of course better.

Nir

>
> > In addition, we are aware of https://bugzilla.redhat.com/1213786, where
> a
> > -u (unsafe) option is planned to be added (see comment #4 in the BZ). Can
> > you please confirm that once that support is released, it won't break
> > existing, i.e. code that provides size and backing format assuming that
> > "unsafe" create is supported?
>
> If we tighten things to require the backing file to exist unless -u is
> provided, then providing the size alone will no longer be sufficient to
> prevent the probe - you'd have to use -u to prevent the probe, or change
> your workflow to create the image without a backing file then add in the
> backing information via 'qemu-img rebase -u'.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266 <(919)%20301-3266>
> Virtualization:  qemu.org | libvirt.org
>
>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fLoFM-0002rZ-9I
	for qemu-devel@nongnu.org; Thu, 24 May 2018 07:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fLoFL-0005ja-97
	for qemu-devel@nongnu.org; Thu, 24 May 2018 07:17:28 -0400
Date: Thu, 24 May 2018 12:17:13 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180524111713.GA4660@redhat.com>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180518170956.GI8615@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180518170956.GI8615@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kwolf@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

On Fri, May 18, 2018 at 06:09:56PM +0100, Daniel P. Berrang=E9 wrote:
> The closest to a cross-hypervisor standard is OVF which can store
> metadata about required hardware for a VM. I'm pretty sure it does
> not have the concept of machine types, but maybe it has a way for
> people to define metadata extensions. Since it is just XML at the
> end of the day, even if there was nothing official in OVF, it would
> be possible to just define a custom XML namespace and declare a
> schema for that to follow.

I have a great deal of experience with the OVF "standard".
TL;DR: DO NOT USE IT.

Long answer copied from a rant I wrote on an internal mailing list a
while back:

  Don't make the mistake of confusing OVF for a format.  It's not,
  there are at least 4 non-interoperable OVF "format"s around:

   - 2 x oVirt OVF
   - VMware's OVF used in exported OVA files
   - VirtualBox's OVF used in their exported OVA files

  These are all different and do not interoperate *at all*.  So before
  you decide "let's parse OVF", be precise about which format(s) you
  actually want to parse.

  Also OVF is a hideous format.  Many fields are obviously internal data
  dumps of VMware structures, complete with internal VMware IDs instead
  of descriptive names.  Where there are descriptive names, they use
  English strings instead of keywords, like: <rasd:AllocationUnits>MetaBy=
tes</>
  or my particular WTF favourite, a meaningful field which references
  English (only) Wikipedia:

    <Disk ovf:format=3D"http://en.wikipedia.org/wiki/Byte">

  File references are split over two places, and there are other
  examples where data is needlessly duplicated or it's unclear what data
  is supposed to be.

  Of course VMware Inc. are not stupid enough to use this format for
  their own purposes.  They use a completely different format (VMX)
  which is a lot like YAML.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW

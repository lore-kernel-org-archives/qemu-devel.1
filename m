Received: from eggs.gnu.org ([2001:4830:134:3::10]:33745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFYCh-0003Z4-B2
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 23:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFYCe-00015U-6E
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 23:24:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eFYCd-00014u-Sw
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 23:24:32 -0500
Date: Fri, 17 Nov 2017 06:24:24 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171117061610-mutt-send-email-mst@kernel.org>
References: <1510769835-31902-1-git-send-email-mst@redhat.com>
	<CAFEAcA_f_Pxd8aX606KBamm4sKvodr1xt9o4_hbONnqx1uTBBQ@mail.gmail.com>
	<20171116173033-mutt-send-email-mst@kernel.org>
	<20171116154534.GR16461@redhat.com>
	<20171116175149-mutt-send-email-mst@kernel.org>
	<CAFEAcA_DqWVaZ-oK8S9j9Hqu_AJ5nE2g9waf7Gd5vmeyKGZLsA@mail.gmail.com>
	<20171116161344.GU16461@redhat.com>
	<CAFEAcA8BC9WPTRFhr_DTAZw9EZRi54-iHCZ+FHyL5g1YtC=j=g@mail.gmail.com>
	<beefcb74-c05b-a594-abab-01080fa75c22@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beefcb74-c05b-a594-abab-01080fa75c22@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/10] pc, pci, virtio: fixes for rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.a@redhat.com>

On Thu, Nov 16, 2017 at 05:43:52PM +0100, Thomas Huth wrote:
> On 16.11.2017 17:15, Peter Maydell wrote:
> > On 16 November 2017 at 16:13, Daniel P. Berrange <berrange@redhat.com> wrote:
> >> On Thu, Nov 16, 2017 at 04:10:22PM +0000, Peter Maydell wrote:
> >>> If there are known-buggy iasl versions in the wild we could
> >>> consider a configure test and treat buggy-iasl like no-iasl.
> >>
> >> iasl has long been broken on big-endian, but it has also long contained
> >> code that simply makes it exit immediately in that case, and qemu copes
> >> with that. So if there's buggy iasl it would be a distro which removed
> >> this big-endian check and tried to make it work on big-endian but failed.
> >> Fedora tried the latter, but at least in rawhide it works properly now.
> >> I'm unclear if we shipped broken iasl with the BE check removed in stable
> >> versions though
> > 
> > In this case this is Ubuntu 16.04.2 LTS (xenial) on s390x, with
> > 
> > linux1@lxub05:~$ iasl -v
> > 
> > Intel ACPI Component Architecture
> > ASL+ Optimizing Compiler version 20160108-64
> > Copyright (c) 2000 - 2016 Intel Corporation
> 
> That's likely a broken version, indeed. I've noticed that the iasl that
> ships with the acpica-tools in RHEL7 is broken, too - it does not
> contain the big-endian check (yet?), and fails to byte-swap on big
> endian hosts.
> 
> If you compile the latest version from upstream, you get this instead:
> 
> $ iasl -v
> iASL is not currently supported on big-endian machines.
> 
> But as Daniel already wrote: The version from Fedora contains some
> patches that fix the endianess issue, so that iasl with these patches
> also works fine on big endian hosts:
> 
>  https://src.fedoraproject.org/rpms/acpica-tools/blob/master/f/big-endian.patch
>  https://src.fedoraproject.org/rpms/acpica-tools/blob/master/f/big-endian-v2.patch
> 
>  Thomas

For the record, I think we should remove the dependency on iasl for
tests too. It is still a handy tool for debugging, so the following
would be a good plan IMHO:

- compare binary actual to expected in memory
- on match pass and skip iasl
- on mismatch, generate aml, run iasl, show
  output in existing format.
  then fail
- when generating expected files, print diff
  and make it easy to append to commit log


-- 
MST

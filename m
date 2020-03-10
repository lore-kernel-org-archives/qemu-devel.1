Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950B9C18E5C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 22:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575E621927
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 22:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dA2nB/E4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575E621927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBmx9-0006Ce-Ib
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 18:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBmvz-00054D-G3
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 18:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBmvx-0000oW-9e
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 18:01:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57638
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBmvw-0000nL-Vj
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 18:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583877663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L1NDYliNSWP35Nq7H3HuTbJ9TLoB3GWHv9JMEanxTQ0=;
 b=dA2nB/E4drl0JOP2NKrWydv/Esk6sEVlezvK0ke4LiRngliJiT9JIrGzrUpoHKoAiecjRl
 Q072y4X7glLwYWlmd2jLL6IS7qMVcBhquktYA5AaNWePb9DdDrai7NzY73M+K3f+wq+cyU
 CMmf+jt21XW2S264jq+UtLwE+DzC9fc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-E94Mh9oIPqy4TilVAsqY3g-1; Tue, 10 Mar 2020 18:00:58 -0400
X-MC-Unique: E94Mh9oIPqy4TilVAsqY3g-1
Received: by mail-qv1-f70.google.com with SMTP id z4so85219qvj.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 15:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kD813WXKCkm49CGiIxZQApiC68QPnOQn5d2thMVbOpA=;
 b=A4CoUwHKrikGxweFfW3s/XnrEdk+JeXLGKqLpOKXstzRZPbtbapp8S6sbAXhrerF8g
 PIx4L9iWwCkIyHmEwzNLNR/KPpq+TkceFbFbMBLGGrE1HMssQuSmk526RaF7188wdGCv
 CBK7YH8dZqBoUVAK3XmIH5e+dYnZKdjH9OVB2st6O6qhkw7TOkhh5jzTF/RIIc4MPMsZ
 Zh7tgPcBEpyYEwHIAiQL/lUlKzwXPP14go6oSF71BZQqb4mYORBRqMIFcXl/t3UmwDQx
 YzeXSNKiY6E4cK/KMho0VVuPBpZ9mhzBWrG/ebEKNzxJA0PgUS2LuK5YCUP00n1mX7zU
 yUFg==
X-Gm-Message-State: ANhLgQ2GcIkhtF5TjtvnbFJhtWlVsqVN6pAgnYjSWJYiNQUTtEZRC6Sk
 PbxWKkgdLo5P4D3qw8gK/XaA2BZBIqBiAJ+IkYFY01LR5s1siE10dBDBFknPmluRmtbJ3WiOYen
 midEHkiKMq+8hn7Q=
X-Received: by 2002:a37:6285:: with SMTP id w127mr26818qkb.138.1583877657604; 
 Tue, 10 Mar 2020 15:00:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vubrrfc+sqBHCVOXGfE/U/a3yL9p4FJVQyN4pvDy+YIbf/8B4LMtAafZ6/eBNePjaRdeoI3Hg==
X-Received: by 2002:a37:6285:: with SMTP id w127mr26779qkb.138.1583877657141; 
 Tue, 10 Mar 2020 15:00:57 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id u13sm24166784qtg.64.2020.03.10.15.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 15:00:56 -0700 (PDT)
Date: Tue, 10 Mar 2020 18:00:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v2 00/16]: hw/i386/vmport: Bug fixes and improvements
Message-ID: <20200310175825-mutt-send-email-mst@kernel.org>
References: <20200310165332.140774-1-liran.alon@oracle.com>
 <20200310133932-mutt-send-email-mst@kernel.org>
 <bcf7f439-7954-a6dc-322e-f8cbddd51d24@oracle.com>
 <20200310164239-mutt-send-email-mst@kernel.org>
 <b191ba0e-a864-fdc2-a029-c22783eb0106@oracle.com>
 <20200310173020-mutt-send-email-mst@kernel.org>
 <95fdfa38-1ef1-8735-2d50-e24c8a909144@oracle.com>
MIME-Version: 1.0
In-Reply-To: <95fdfa38-1ef1-8735-2d50-e24c8a909144@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: nikita.leshchenko@oracle.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 11:57:49PM +0200, Liran Alon wrote:
>=20
> On 10/03/2020 23:44, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 02:29:42PM -0700, Liran Alon wrote:
> > > On 10/03/2020 22:56, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 10, 2020 at 08:09:09PM +0200, Liran Alon wrote:
> > > > > On 10/03/2020 19:44, Michael S. Tsirkin wrote:
> > > > > > On Tue, Mar 10, 2020 at 06:53:16PM +0200, Liran Alon wrote:
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > This series aims to fix several bugs in VMPort and improve it=
 by supporting
> > > > > > > more VMPort commands and make command results more configurab=
le to
> > > > > > > user via QEMU command-line.
> > > > > > >=20
> > > > > > > This functionality was proven to be useful to run various VMw=
are VMs
> > > > > > > when attempting to run them as-is on top of QEMU/KVM.
> > > > > > >=20
> > > > > > > For more details, see commit messages.
> > > > > > Well two versions in one day and some review comments weren't a=
ddressed.
> > > > > There is a single review comment that wasn't addressed which is r=
eplacing an
> > > > > enum with a comment. And I explicitly mentioned that it's because=
 I want
> > > > > additional opinion on this.
> > > > > I don't see why such a small thing should block review for 15 pat=
ches...
> > > > > All the rest of the comments (Which were great) have been address=
ed. Unless
> > > > > I have mistakenly missed something, which please point it out if =
I did.
> > > > OK I just took a quick peek, two things quickly jumped out at me.
> > > Thanks for having a look.
> > > > version property really should be a boolean and have some documenta=
tion
> > > > saying what functionality enables.
> > > I thought that having a version number approach is more generic and e=
asy to
> > > maintain going forward.
> > > If I understand correctly, this is also the approach taken by qxl & q=
xl-vga.
> > >=20
> > > The more elaborate alternative could have been introducing compat_fla=
gs (As
> > > PVSCSI does) but it seems like it will pollute the property space wit=
h a lot
> > > of useless VMPort properties.
> > > (E.g. x-read-eax-bug, x-no-report-unsupported-cmd, x-no-report-vmx-ty=
pe and
> > > etc.).
> > >=20
> > > What is the advantage of having a boolean such as "x-vmport-v2" inste=
ad of
> > > having a single "version" property?
> > It's not clear what should happen going forward. Let's say version is
> > incremented again. This then becomes challenging for downstreams to
> > backport.
> As all conditions are in the form of "if (s->version > X)" then increment=
ing
> version from 1 to 2 doesn't break any condition of "if (s->version > 1)".
> What is the challenge of backporting I'm missing?

the challenge is figuring out which parts does version apply to.
It might be easy if there's just code, harder if there's
also data, etc.


> >=20
> > > Will it suffice if I would just add documentation above "version" pro=
perty
> > > on what is was the functionality in "version=3D=3D1"?
> > > (Though, it's just easy to scan the vmport.c code for if's involving
> > > ">version"... "version" is more of an internal field for machine-type
> > > compatibility and not really meant to be used by user)
> > >=20
> > > Which approach do you prefer?
> > I just dislike versions, they are hard to maintain.
> >=20
> > Individual ones is cleanest imho. Self-documenting.
> I agree. That's the PVSCSI approach of compat_flags. Have many properties
> but each define bit in a compat_flags that specifies behavior.
> The disadvantage it have is that it over-complicates code and introduce m=
any
> properties that will never be used as it's just for internal binding to
> machine-type.
> > But if not, I'd do something like "x-vmport-fixes" and
> > set bits there for each bugfix.
> Hmm this could a nice and simple approach.
> Will it be OK then in this case to define "x-vmport-fixes" value in
> hw_compat_4_2[] to a hard-coded value (e.g. "20") without directly encodi=
ng
> each individual bit via vmport.h constants?

Well how are you going to check a specific flag then?

> I will note though that it seems this "x-vmport-fixes" bitmap seems to be
> the first of it's kind. But I'm OK with this approach.
> >=20
> >=20
> > > > userspace properties should use the non-abbreviated
> > > > vm-executable since vmx is easy to confuse with vm extensions.
> > > I really wish you would reconsider this. VMX is a really common term =
in
> > > VMware terminology.
> > > It is found in binary names, ".vmx" file, ".vmx" file properties, VMw=
are
> > > Tools prints, open-vm-tools source code and etc.
> > Well that at least is easy to google.
> >=20
> > =09.vmx
> >=20
> > =09<vmname>.vmx
> >=20
> > =09This is the primary configuration file, which stores settings
> > =09chosen in the New Virtual Machine Wizard or virtual machine settings
> > =09editor. If you created the virtual machine under an earlier version =
of
> > =09VMware Workstation on a Linux host, this file may have a .cfg extens=
ion
> >=20
> > so .vmx as used here has nothing to do with VM Executable version or
> > type. Looks like it's just a source of confusion on the vmware
> > side too :)
> Well, the ".vmx" file is the configuration file for the VM given to VMX. =
But
> I agree VMware terminology is weird. :)
> > > In contrast, even though I have dealt for many years with VMware
> > > technologies, I have never known that VMX=3D=3Dvm-executable.
> > Well you said that's what it stands for. I have no idea.  From what you
> > say now maybe vmx basically is being used as a prefix for all things
> > vmware.
> No. It's just use to specify things related to VMX. i.e. The host VMM.
> > In that case vmport-version and vmport-type or even
> > vmware-version and vmware-type will do just as well.
> vmware-version is also confusing. As one could confuse it with the produc=
t
> version number.
> VMware called this field "vmx-version" and "vmx-type". I don't know if th=
ey
> have another field that maybe is called "vmware-version"...
> > > I still think it will introduce much confusion. On the other hard, I =
don't
> > > see much confusing with this use of VMX with Intel VT-x
> > > because it is only used inside vmport.c and in vmport properties name=
s. And
> > > the properties names match the names of the guest
> > > code that interface with vmport in open-vm-tools source code.
> > >=20
> > > If you still have a strong opinion on this, I will change it as you s=
ay in
> > > v3... But please consider above arguments.
> > I'm just saying don't use vmx. It's too late to try to give
> > it a different meaning.
> We are giving it here the same meaning VMware gave it. In the context of
> VMware VMPort.
> >   Figure out what it's supposed to
> > stand for and write it out in full.
> VMX stands for the host VMM. But I don't see why I need to be in the
> position explaining the reason behind VMware terminology.
> I'm just suggesting to use it as-is to avoid confusion.
>=20
> It seems you are still not convinced by above arguments, so I will change
> this in v3 to what you preferred "vm-exec-version" & "vm-exec-type".
> I think this is a mistake but you have the final call as the maintainer a=
nd
> I accept that.
>=20
> -Liran
>=20



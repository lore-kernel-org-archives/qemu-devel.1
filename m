Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20963C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D076420727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ii5/6mmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D076420727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgbO-0006Tr-GV
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBgXK-0008Ll-7V
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBgXH-0007GJ-KB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:11:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBgXH-0007EW-Cc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583853071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KnR3Ff/QjTQRNa9kyc8ai4rghMaZ7rp539YXa7QfJoI=;
 b=ii5/6mmYYwddi7jqnPtiPD8XI0mvilsE09aGJ+Ch7PUEAT/Hd0uzkLHABDOYewMMCwJAg+
 xzuVQqT65VxJdaXJF1LL7g9Vpu5lchoIMINEgaWjiXfF7IIBoSzVWTWWGBsoulleiKDExX
 /CeWkpH7Z8RgNNzpk5REr2AbBOoxmfI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-dOD7ta9zPgiDAdOTgmEE3g-1; Tue, 10 Mar 2020 11:11:07 -0400
X-MC-Unique: dOD7ta9zPgiDAdOTgmEE3g-1
Received: by mail-qv1-f72.google.com with SMTP id a12so8785015qvv.8
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 08:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=YFWfZraxPaIDkjZNNBFaQ83cSwtU/7jdsIKwO6j+qqE=;
 b=SE7ws7sut5HBApoIwOg79s9BOKaPsy4Gff2k73p1+mddfOfRaWUoeaMcf8Ib+mP+UH
 WcgDxpbjo7j4QUKzyEP0UXHS4xOBSj8ApXaLtXNZbm7v2717VxoHMCtcY4Q4JThEo+WV
 SLNTOYZlm4QKvlu1+Zm7Lu2790E0xu4yEKbBahxyo1GEe9d5n11K0VlN+g1uz/6MYACV
 rHa0UUoiz2Z90HuIgkkKpPifFSNfVAmYY0ICerN8EmLig+Wmp8+QWAoE7t7zhiVZVebo
 O2mAUsVgeRUevQSFdUs3YnRjoiTA407il6gBsX+59swLPav7w3fWDdU4HUM/iHasMJnF
 gcaQ==
X-Gm-Message-State: ANhLgQ1WFEvYp4sVbiAl6t52gi0FV7Y4LjW09M9LpH1aQ1TCzHZPhmPy
 RgFusqw+NS5c5S0tUuDQVB7/8rEP429VbKHqgM60iCMwr4yjsrKIT2n/fjUZHN+MxlJf7PiuSpo
 1ETzSZq9VKqZHFjU=
X-Received: by 2002:a37:987:: with SMTP id 129mr2081265qkj.83.1583853066426;
 Tue, 10 Mar 2020 08:11:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu2iPoHraXrA7pgzEXPg4PDggr88FN0ce1ZJdy/EXjrmLZwfunL88SQIu3B4+2cB/w0qw0+Ew==
X-Received: by 2002:a37:987:: with SMTP id 129mr2081226qkj.83.1583853065882;
 Tue, 10 Mar 2020 08:11:05 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id a21sm3525730qtp.25.2020.03.10.08.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 08:11:04 -0700 (PDT)
Date: Tue, 10 Mar 2020 11:10:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
Message-ID: <20200310104713-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-6-liran.alon@oracle.com>
 <20200310081144-mutt-send-email-mst@kernel.org>
 <43b5d99e-70f2-39dc-1a12-e6c6d9e75d5a@oracle.com>
 <20200310082730-mutt-send-email-mst@kernel.org>
 <506ba498-ba50-9415-18b3-bcaff1561c55@oracle.com>
 <20200310084758-mutt-send-email-mst@kernel.org>
 <1f4766b2-9683-8ebf-752e-a0378bb0cbc3@oracle.com>
 <20200310094350-mutt-send-email-mst@kernel.org>
 <6d3c248f-f8fe-754d-59e5-8f2740a55263@oracle.com>
MIME-Version: 1.0
In-Reply-To: <6d3c248f-f8fe-754d-59e5-8f2740a55263@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 04:46:19PM +0200, Liran Alon wrote:
>=20
> On 10/03/2020 16:08, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 03:35:25PM +0200, Liran Alon wrote:
> > > On 10/03/2020 14:53, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 10, 2020 at 02:43:51PM +0200, Liran Alon wrote:
> > > > > On 10/03/2020 14:35, Michael S. Tsirkin wrote:
> > > > > > On Tue, Mar 10, 2020 at 02:25:28PM +0200, Liran Alon wrote:
> > > > > > > On 10/03/2020 14:14, Michael S. Tsirkin wrote:
> > > > > > > > On Tue, Mar 10, 2020 at 01:54:02AM +0200, Liran Alon wrote:
> > > > > > > > > As can be seen from VmCheck_GetVersion() in open-vm-tools=
 code,
> > > > > > > > > CMD_GETVERSION should return VMX type in ECX register.
> > > > > > > > >=20
> > > > > > > > > Default is to fake host as VMware ESX server. But user ca=
n control
> > > > > > > > > this value by "-global vmport.vmx-type=3DX".
> > > > > > > > >=20
> > > > > > > > > Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.co=
m>
> > > > > > > > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > > > > > > > > ---
> > > > > > > > >      hw/i386/vmport.c | 13 +++++++++++++
> > > > > > > > >      1 file changed, 13 insertions(+)
> > > > > > > > >=20
> > > > > > > > > diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> > > > > > > > > index a2c8ff4b59cf..c03f57f2f636 100644
> > > > > > > > > --- a/hw/i386/vmport.c
> > > > > > > > > +++ b/hw/i386/vmport.c
> > > > > > > > > @@ -36,6 +36,15 @@
> > > > > > > > >      #define VMPORT_ENTRIES 0x2c
> > > > > > > > >      #define VMPORT_MAGIC   0x564D5868
> > > > > > > > > +typedef enum {
> > > > > > > > > +   VMX_TYPE_UNSET =3D 0,
> > > > > > > > > +   VMX_TYPE_EXPRESS,    /* Deprecated type used for VMwa=
re Express */
> > > > > > > > > +   VMX_TYPE_SCALABLE_SERVER,    /* VMware ESX server */
> > > > > > > > > +   VMX_TYPE_WGS,        /* Deprecated type used for VMwa=
re Server */
> > > > > > > > > +   VMX_TYPE_WORKSTATION,
> > > > > > > > > +   VMX_TYPE_WORKSTATION_ENTERPRISE /* Deprecated type us=
ed for ACE 1.x */
> > > > > > > > > +} VMX_Type;
> > > > > > > > > +
> > > > > > > > Is this really VMX type? And do users care what it is?
> > > > > > > This enum is copied from open-vm-tools source code
> > > > > > > (lib/include/vm_version.h). This is how it's called in VMware=
 Tools
> > > > > > > terminology... Don't blame me :)
> > > > > > I don't even want to go look at it to check license compatibili=
ty, but
> > > > > > IMHO that's just another reason to avoid copying it.
> > > > > > Copying bad code isn't a good idea unless needed for
> > > > > > compatibility.
> > > > > Preserving original VMware terminology makes sense and is preferr=
ed in my
> > > > > opinion. I think diverging from it is more confusing.
> > > > Yea tell it to people who got in hot water because they copied
> > > > some variable names to avoid confusion. Oh wait.
> > > >=20
> > > > This is not an official terminology I think.
> > > Maybe it wasn't clear from my previous messages, but open-vm-tools is=
 an
> > > official VMware open-source project...
> > > VMX is the official name of the VMware Userspace-VMM and VMX-Type is =
an
> > > official name as-well.
> > >=20
> > > I'm also not copying code here... I'm copying definitions from releva=
nt
> > > header files to implement a compatible interface.
> > You don't need to have enum have same names to be compatible.
> > And in this case, all we really need is just a single number *2*
> > and a comment saying that's ESX server.
> I don't have to. I want to. It makes code much more clearer to reader. I
> don't see any harm in that.

It's just a bad interface for QEMU to use. Maybe it's good for vmware,
I would not know.

> >=20
> > > This is no different than copying constants from a Linux device drive=
r to
> > > implement it's device emulation in QEMU.
> > We really try to avoid stuff like this. If one does this one has to
> > check license etc etc.
> There is no license issue here. It's only definitions. And if you really
> wonder about it, this is the license written in the header files of
> open-vm-tools:
> /*********************************************************
> =A0* Copyright (C) 2006 VMware, Inc. All rights reserved.
> =A0*
> =A0* This program is free software; you can redistribute it and/or modify=
 it
> =A0* under the terms of the GNU Lesser General Public License as publishe=
d
> =A0* by the Free Software Foundation version 2.1 and no later version.

OK that is already a conflict with the license of vmport.c
which is copyleft. Respecting wishes of the original
author is not a legal requirement, but sure is a nice thing to do.

I suggest we keep clear of this.

Refer to it if you like but don't copy.

And "no later version" will conflict with a bunch of other
files which are 2 or later.
We can't avoid GPL v2 but we really shouldn't just add it
without any good reason.

> =A0* This program is distributed in the hope that it will be useful, but
> =A0* WITHOUT ANY WARRANTY; without even the implied warranty of
> MERCHANTABILITY
> =A0* or FITNESS FOR A PARTICULAR PURPOSE.=A0 See the Lesser GNU General P=
ublic
> =A0* License for more details.
> =A0*
> =A0* You should have received a copy of the GNU Lesser General Public Lic=
ense
> =A0* along with this program; if not, write to the Free Software Foundati=
on,
> Inc.,
> =A0* 51 Franklin St, Fifth Floor, Boston, MA=A0 02110-1301 USA.
> =A0*
> =A0*********************************************************/
> > But in this case, the names are confusing,
> > violate our coding style, I could go on.
> The only thing that violates the coding style is "VMX_Type" enum type nam=
e
> instead of "VMXType".

All enum names too. Supposed to be CamelCase. Again VMX is=20


> And that is right and I will change it in v2. However,
> the rest doesn't violate coding style.
> In addition, I disagree this is confusing. These are official VMX product
> names defined by VMware.

They might make sense in the context of the specific project.
They aren't official names - just internal strings within a file.


> I don't see any value in renaming them. It just
> results in additional confusion.
> >=20
> >=20
> > > > So please just make it make sense by itself, and make it
> > > > easy to research.
> > > I think I have made it the most easiest to research. Having exactly s=
ame
> > > names as VMware official project and pointing to it directly from com=
ments
> > > and commit messages.
> > What good does this do when that code will change tomorrow?
> Why would the enum constants change tomorrow?
> And even if that will happen, it still allows a reader to just search in
> Google the name of the constant and find results.
> Which is better than just making up names that we think our more intuitiv=
e
> than the names VMware decided for their own product.
> >=20
> > You worry about code being easy to write, I worry about it
> > being easy to read.
>=20
> No I don't. This doesn't matter at all for writing code but matters only =
to
> reading it.
>=20
> >=20
> > Here are things we can do to make things easier for users and readers:
> > - use full name VM executable instead of VMX
> Why? Searching for "VMware VM executable" in Google provides completely
> unrelated results.
> In contrast, searching for "VMware VMX" provides concrete related results=
.
> We shouldn't rename terminology given by VMware itself to it's own produc=
t.
> It just adds confusion in my opinion.
> > - put in official product names in comments instead of enums
> I don't see how it provides extra value. Especially due to the fact that =
the
> enum constants have their more common product name next to them in commen=
t.
> I provide both reference that can be searched in other VMware projects an=
d
> web and the more user-friendly well-known name.
> > - write code using our coding style
> Will do. The only coding style violation I see here is the enum type name=
.
> Will change from "VMX_Type" to "VMXType".
> The rest seems not violating coding convention. Please tell me if I misse=
d
> something.
> > - add a link to where you found a specific number in comments
> Good idea. Will add a link to open-vm-tools git repo in vmport.c comment =
in
> general.
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > > > > > > > Also, how about friendlier string values so people don't ne=
ed to
> > > > > > > > figure out code numbers?
> > > > > > > I could have defined a new PropertyInfo struct in hw/core/qde=
v-properties.c
> > > > > > > for this enum and then define a proper macro in qdev-properti=
es.h.
> > > > > > > But it seems like an overkill for a value that is suppose to =
rarely be
> > > > > > > changed. So I thought this should suffice for now for user-ex=
perience
> > > > > > > perspective.
> > > > > > > If you think otherwise, I can do what I just suggested above.
> > > > > > >=20
> > > > > > > -Liran
> > > > > > I think that's better, and this allows you to use official
> > > > > > product names that people can relate to.
> > > > > Ok. Will do...
> > > > > > Alternatively just drop this enum completely.  As far as you ar=
e
> > > > > > concerned it's just a number VM executable gives together with =
the
> > > > > > version, right?  We don't even need the enum, just set it to 2 =
and add a
> > > > > > code comment saying it's esx server.
> > > > > I could do the latter alternative but why? It just hides informat=
ion
> > > > > original patch author (myself) know about where this value comes =
from.
> > > > > I don't see a reason to hide information from future code maintai=
ners.
> > > > > Similar to defining all flags of a given flag-field even if we us=
e only a
> > > > > subset of it.
> > > > >=20
> > > > > -Liran
> > > > That belongs in a code comment. Removes need to follow silly names =
from
> > > > unrelated and possibly incompatible license.
> > > What do you mean "unrelated"? It's an official VMware open-source pro=
ject
> > > for VMware Tools...
> > > I'm only copying definition of constants...
> > No you also copy names and comments. Which might make sense in the
> > context of the original project but seem to make no sense here.
> > E.g. for vmware a given product is deprecated but why does QEMU care?
> What is the harm in specifying that? It gives more context.
> > enum values are not even listed. What is poor user supposed to do -
> > take out a calculator to figure it out?
> What do you mean by listed?

So imagine: as a user, I want to set this to some reasonable value.

Supposedly this is why you have the enum there in the
1st place right? Let's see how does all this help me:

- first enum is VMX_TYPE_UNSET. Unset? I guess that's
the default. I want to set it, make sure it's a good value.
- next one is VMX_TYPE_EXPRESS. comment says deprecated though.
  I will keep clear.
- Next enum is VMX_TYPE_SCALABLE_SERVER. Hmm that says ESX.
I guess it's good! However what's scalable server?
There's no vmware in sight,
brings up unrelated search results.
Scalable server? No I need to research that.
I guess I will just ignore all this and go by the comments.
Okay! Wait so what is the value I need to supply to the
property?
Oh right I need to recall that enum values are sequential.
So first one it says is 0. Let me count. It's 2 I guess.

Okay I will try ...




> >=20
> > > > By comparison dead code is
> > > > dead code.
> > > Right. That's why I think the enum PropertyInfo mechanism is an overk=
ill at
> > > this point.
> > > > But sure, if you want to code up user friendly names, that's
> > > > ok too. But do follow official names then please, not something lif=
ted
> > > > from some piece of code.
> > > These are all official names.
> > Official as in will stick around, not official as in pushed to
> > a github repo.
> >=20
> >=20
> > > I'm not sure I understand what you are
> > > suggesting.
> > >=20
> > > -Liran
> > Something like the below.
> >=20
> > /*
> >   * Most guests are fine with the default.
> >   * Some legacy guests hard-code a given type.
> >   * See https://urldefense.com/v3/__https://github.com/vmware/open-vm-t=
ools/blob/master/open-vm-tools/lib/include/vm_vmx_type.h__;!!GqivPVa7Brio!M=
9wko4CSBSs3xFA2QY7MIL_jvAxlU5aRZE1jN2hzG5jnk8rdlpYCDs2ymrkJ8GE$
> >   * for an up-to-date list of values.
> >   *
> >   * Reasonable options:
> >   * 0 - unset?
> >   * 1 - VMware Express (deprecated)
> >   * 2 - VMware ESX server
> >   * 3 - VMware Workstation
> >   * 4 - ACE 1.x (deprecated)
> >   */
> >=20
> > DEFINE_PROP_UINT8("vm-executable-type", VMPortState, vm_executable_type=
, 2 /* VMware ESX server */),
> >=20
> Why is it better to specify a list of all options in a comment than an en=
um?

Because that lets you use english. Look you didn't even list options.
User's supposed to do the math in his/her head. Why is that?
Oh because we lifted this wholesale from some other header.

> Isn't enum invented exactly for enumerating all possible values of a fiel=
d?

No - it just assigns names to constants. If you then proceed not to use
the names, then it's pointless.

> Note that even in this simple case, you needed to write "VMware ESX serve=
r"
> twice instead of referring to an enum constant. It doesn't seem more eleg=
ant
> to me.

I felt this bears repetition.
But sure, you can drop it in DEFINE_PROP_UINT8 if you like.
If you really feel you must, do:

#define VM_PORT_DEFAULT_VM_EXECUTABLE 2
near the comment.


> And again, I disagree with renaming the field to "vm-executable-type"
> instead of "vmx-type".
>=20
> -Liran

Acronims is a bad idea in user interfaces if avoidable, or unless
universal. Either these interfaces are needed or they aren't.
I question their usefulness, but if they are useful they should
have names that do not require guesswork to understand.

--=20
MST



Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70B6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 22:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8F420829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 22:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McPDBUmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8F420829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Gx3-0003FA-Te
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 18:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dwalsh@redhat.com>) id 1k1GwE-0002oB-Ui
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 18:22:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39190
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dwalsh@redhat.com>) id 1k1GwC-0002Rf-9F
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 18:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596147726;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:
 references:references:autocrypt:autocrypt;
 bh=Y1cKD27J2XFr4nuby+7bV+U3THT7kac+QiZ54wMBRSg=;
 b=McPDBUmtX1w0HYrM8I3uJcVV0r2oWSGz2WT0TVlMYv0RtKEj9tUJMxK1r5yPwRPdv+sL9i
 0j+bsLKGTHvE8WSdn5IWno1HTrrjMwYk+T06wjgbsDpQMsOLTbsHokfhYXskegIqNtgikO
 ggZArrxXPV0k6lgezT8u/nw56OifyAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-WeuF1M5GNZakO-PzRsD0zQ-1; Thu, 30 Jul 2020 18:22:04 -0400
X-MC-Unique: WeuF1M5GNZakO-PzRsD0zQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87C0C80B713;
 Thu, 30 Jul 2020 22:21:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-113-2.phx2.redhat.com [10.3.113.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D41C269314;
 Thu, 30 Jul 2020 22:21:36 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
 error
To: Stefan Hajnoczi <stefanha@redhat.com>, Roman Mohr <rmohr@redhat.com>
References: <20200727190223.422280-1-stefanha@redhat.com>
 <20200727190223.422280-4-stefanha@redhat.com>
 <OSBPR01MB45826073E5A54CF869E56721E5730@OSBPR01MB4582.jpnprd01.prod.outlook.com>
 <CALDPj7syG0KPhtZEma5n403=YFZ2ptcD4MtP=GdrY9n1eUs5Eg@mail.gmail.com>
 <20200728131250.GB78409@redhat.com>
 <CALDPj7uvquu=YWX_Ve7ROdj=LZWjkgPOm+wvEAynGvjeF4Xivg@mail.gmail.com>
 <20200729144027.GF52286@stefanha-x1.localdomain>
From: Daniel Walsh <dwalsh@redhat.com>
Autocrypt: addr=dwalsh@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFsaqOEBCADBSnZCZpi262vX8m7iL/OdHKP9G9dhS28FR60cjd8nMPqHDNhQJBjLMZra
 66L2cCIEhc4HEItail7KU1BckrMc4laFaxL8tLoVTKHZwb74n2OcAJ4FtgzkNNlB1XJvSwC/
 909uwt7cpDqwXpJvyP3t17iuklB1OY0EEjTDt9aU4+0QjHzV18L4Cpd9iQ4ksu+EHT+pjlBk
 DdQB+hKoAjxPl11Eh6pZfrAcrNWpYBBk0A3XE9Jb6ghbmHWltNgVOsCa9GcswJHUEeFiOup6
 J5DTv6Xzwt0t6QB8nIs+wDJH+VxqAXcrxscnAhViIfGGS2AtxzjnVOz/J+UZPaauIGXTABEB
 AAG0LERhbmllbCBKIFdhbHNoIChGb3IgR2l0KSA8ZHdhbHNoQHJlZGhhdC5jb20+iQE4BBMB
 AgAiBQJbGqjhAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCi35Adq+LAKHuJB/98
 nZB5RmNjMWua4Ms8q5a1R9XWlDAb3mrST6JeL+uV/M0fa18e2Aw4/hi/WZHjAjoypLmcuaRx
 GeCbC8iYdpfRDUG79Y956Qq+Vs8c6VfNDMY1mvtfb00eeTaYoOCu0Aa9LDeR9iLKh2g0RI+N
 Zr3EU45RxZdacIs1v6mU8pGpyUq/FvuTGK9GzR9d1YeVCuSpQKN4ckHNZHJUXyk0vOZft1oO
 nSgLqM9EDWA+yz1JLmRYwbNsim7IvfVOav5mCgnKzHcL2mLv8qCnMFZjoQV8aGny/W739Z3a
 YJo1CdOg6zSu5SOvmq9idYrBRkwEtyLXss2oceTVBs0MxqQ/9mLPuQENBFsaqOEBCADDl2hl
 bUpqJGgwt2eQvs0Z0DCx/7nn0hlLfEn4WAv2HqP25AjIRXUX31Mzu68C4QnsvNtY4zN+FGRC
 EfUpYsjiL7vBYlRePhIohyMYU4RLp5eXFQKahHO/9Xlhe8mwueQNwYxNBPfMQ65U2AuqxpcS
 scx4s5w208mhqHoKz6IB2LuKeflhYfH5Y1FNAtVGHfhg22xlcAdupPPcxGuS4fBEW6PD/SDf
 Y4HT5iUHsyksQKjM0IFalqZ7YuLfXBl07OD2zU7WI9c3W0dwkvwIRjt3aD4iAah544uOLff+
 BzfxWghXeo80S2a1WCL0S/2qR0NVct/ExaDWboYr/bKpTa/1ABEBAAGJAR8EGAECAAkFAlsa
 qOECGwwACgkQot+QHaviwCi2hgf/XRvrt+VBmp1ZFxQAR9E6S7AtRT8KSytjFiqEC7TpOx3r
 2OZ4gZ3ZiW4TMW8hS7aYRgF1uYpLzl7BbrCfCHfAWEcXZ+uG8vayg8G/mLAcNlLY+JE76ATs
 53ziEY9R2Vb/wLMFd2nNBdqfwGcRH9N9VOej9vP76nCP01ZolY8Nms2hE383/+1Quxp5EedU
 BN5W5l7x9riBJyqCA63hr4u8wNsTuQgrDyhm/U1IvYeLtMopgotjnIR3KiTKOElbppLeXW3w
 EO/sQTPk+vQ4vcsJYY9Dnf1NlvHE4klj60GHjtjitsBEHzdE7s+J9FOxPmt8l+gMogGumKpN
 Y4lO0pfTyg==
Organization: Red Hat
Message-ID: <ad75a25c-0343-5c57-1933-e3c88f76df1c@redhat.com>
Date: Thu, 30 Jul 2020 18:21:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729144027.GF52286@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9N2k257N4XRNVUKshNFGUkLmO2fv23pOd"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dwalsh@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:41:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: dwalsh@redhat.com
Cc: "vromanso@redhat.com" <vromanso@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
 "mpatel@redhat.com" <mpatel@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9N2k257N4XRNVUKshNFGUkLmO2fv23pOd
Content-Type: multipart/mixed; boundary="LdOFxFkrVx2ggGUCRzZKSsN0ZsHPQIZwX"

--LdOFxFkrVx2ggGUCRzZKSsN0ZsHPQIZwX
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 7/29/20 10:40, Stefan Hajnoczi wrote:
> On Wed, Jul 29, 2020 at 09:59:01AM +0200, Roman Mohr wrote:
>> On Tue, Jul 28, 2020 at 3:13 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>>
>>> On Tue, Jul 28, 2020 at 12:00:20PM +0200, Roman Mohr wrote:
>>>> On Tue, Jul 28, 2020 at 3:07 AM misono.tomohiro@fujitsu.com <
>>>> misono.tomohiro@fujitsu.com> wrote:
>>>>
>>>>>> Subject: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print
>>> an
>>>>> error
>> Yes they can run as root. I can tell you what we plan to do with the
>> containerized virtiofsd: We run it as part of the user-owned pod (a set =
of
>> containers).
>> One of our main goals at the moment is to run VMs in a user-owned pod
>> without additional privileges.
>> So that in case the user (VM-creator/owner) enters the pod or something
>> breaks out of the VM they are just in the unprivileged container sandbox=
.
>> As part of that we try to get also rid of running containers in the
>> user-context with the root user.
>>
>> One possible scenario which I could think of as being desirable from a
>> kubevirt perspective:
>> We would run the VM in one container and have an unprivileged
>> virtiofsd container in parallel.
>> This container already has its own mount namespace and it is not that
>> critical if something manages to enter this sandbox.
>>
>> But we are not as far yet as getting completely rid of root right now in
>> kubevirt, so if as a temporary step it needs root, the current proposed
>> changes would still be very useful for us.
> What is the issue with root in user namespaces?
>
> I remember a few years ago it was seen as a major security issue but
> don't remember if container runtimes were already using user namespaces
> back then.
>
> I guess the goal might be simply to minimize Linux capabilities as much
> as possible?
>
> virtiofsd could nominally run with an arbitrary uid/gid but it still
> needs the Linux capabilities that allow it to change uid/gid and
> override file system permission checks just like the root user. Not sure
> if there is any advantage to running with uid 1000 when you still have
> these Linux capabilities.
>
> Stefan

When you run in a user namespace, virtiofsd would only have
setuid/setgid over the range of UIDs mapped into the user namespace.=A0 So
if UID=3D0 on the host is not mapped, then the container can not create
real UID=3D0 files on disk.

Similarly you can protect the user directories and any content by
running the containers in a really high UID Mapping.



--LdOFxFkrVx2ggGUCRzZKSsN0ZsHPQIZwX--

--9N2k257N4XRNVUKshNFGUkLmO2fv23pOd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE+re/ImQyQPB/0p5rot+QHaviwCgFAl8jR+4ACgkQot+QHavi
wCiANwgAnDgI0CHAk+A7hjznydkpcrAcneBMEMyblibFJNSOdTzcJZ3tyvRnVctI
0rSIELFD/Jc6VWHC/uLr+d2LHFAucVHuSp7rtaz/U1ndHqGUSC8s7l1xuoNSVu3c
8kgRjbYwnVhrbTFdZ4Vpuez04eI9yX5dqyOUAXq8MoABx4b6Nc89hosRFivts3t/
cF7HX8dnlW+zXou8AJuMWvOuj0Rm08QB2nOAPJ/5NzSHXOKjBuQgeEQn4hxZh44G
CpwS9yrdXpJUNJm+NPcV7pN4M82bG77/+2dLI0t8MgCv6GlW1IbiEpSqgkFk58uZ
Eig0gnQFBPu+U9+0kS6UT/o+4T6f4g==
=PDVf
-----END PGP SIGNATURE-----

--9N2k257N4XRNVUKshNFGUkLmO2fv23pOd--



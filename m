Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5EBC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 20:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67520206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 20:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aoK36wdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67520206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Wb7-00042L-NR
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 16:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dwalsh@redhat.com>) id 1k0V55-0004GD-Ob
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 15:16:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57578
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dwalsh@redhat.com>) id 1k0V53-0002pa-Qy
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 15:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595963765;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:
 references:references:autocrypt:autocrypt;
 bh=KLQdPQZxLjG6Pk/mumSR7uLNRy7vel0JXAdm1TtcZpU=;
 b=aoK36wdMqamBotzi/UBjKLLJFoWEs4pU5ooiXT6fp1W86Jiyr/dHgolUNsB89DPfMyHQ16
 DH8tUX6mTN63lqr7bgphI2ZMxQ7HLibjANe/5gUrk6NJd+OP03CxmxccTIvuRgxGoN0L0V
 f4zA9/RWCkTpY0hKjdH2CI5KaPPqf3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-6fLduEyeO4Kj7K3kM5TlhA-1; Tue, 28 Jul 2020 15:16:01 -0400
X-MC-Unique: 6fLduEyeO4Kj7K3kM5TlhA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFC6B10B203D;
 Tue, 28 Jul 2020 19:15:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-113-30.phx2.redhat.com
 [10.3.113.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94DE819C71;
 Tue, 28 Jul 2020 19:15:26 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
 error
To: Stefan Hajnoczi <stefanha@redhat.com>, Roman Mohr <rmohr@redhat.com>
References: <20200727190223.422280-1-stefanha@redhat.com>
 <20200727190223.422280-4-stefanha@redhat.com>
 <OSBPR01MB45826073E5A54CF869E56721E5730@OSBPR01MB4582.jpnprd01.prod.outlook.com>
 <CALDPj7syG0KPhtZEma5n403=YFZ2ptcD4MtP=GdrY9n1eUs5Eg@mail.gmail.com>
 <20200728153219.GC21660@stefanha-x1.localdomain>
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
Message-ID: <c5b15243-200b-fa17-27b5-1b27dbddbe6d@redhat.com>
Date: Tue, 28 Jul 2020 15:15:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728153219.GC21660@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7d5MUWo1b1wuTpcomcKBEn4YNTtHxYDiS"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dwalsh@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 28 Jul 2020 16:52:05 -0400
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
 "mpatel@redhat.com" <mpatel@redhat.com>,
 "vgoyal@redhat.com" <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7d5MUWo1b1wuTpcomcKBEn4YNTtHxYDiS
Content-Type: multipart/mixed; boundary="JVfEqeD0nAxJkdjLPi5gMzABaO9fQnUzz"

--JVfEqeD0nAxJkdjLPi5gMzABaO9fQnUzz
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 7/28/20 11:32, Stefan Hajnoczi wrote:
> On Tue, Jul 28, 2020 at 12:00:20PM +0200, Roman Mohr wrote:
>> On Tue, Jul 28, 2020 at 3:07 AM misono.tomohiro@fujitsu.com <
>> misono.tomohiro@fujitsu.com> wrote:
>>
>>>> Subject: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print a=
n
>>> error
>>>> An assertion failure is raised during request processing if
>>>> unshare(CLONE_FS) fails. Implement a probe at startup so the problem c=
an
>>>> be detected right away.
>>>>
>>>> Unfortunately Docker/Moby does not include unshare in the seccomp.json
>>>> list unless CAP_SYS_ADMIN is given. Other seccomp.json lists always
>>>> include unshare (e.g. podman is unaffected):
>>>>
>>> https://raw.githubusercontent.com/seccomp/containers-golang/master/secc=
omp.json
>>>> Use "docker run --security-opt seccomp=3Dpath/to/seccomp.json ..." if =
the
>>>> default seccomp.json is missing unshare.
>>> Hi, sorry for a bit late.
>>>
>>> unshare() was added to fix xattr problem:
>>>
>>> https://github.com/qemu/qemu/commit/bdfd66788349acc43cd3f1298718ad49166=
3cfcc#
>>> In theory we don't need to call unshare if xattr is disabled, but it is
>>> hard to get to know
>>> if xattr is enabled or disabled in fv_queue_worker(), right?
>>>
>>>
>> In kubevirt we want to run virtiofsd in containers. We would already not
>> have xattr support for e.g. overlayfs in the VM after this patch series =
(an
>> acceptable con at least for us right now).
>> If we can get rid of the unshare (and potentially of needing root) that
>> would be great. We always assume that everything which we run in contain=
ers
>> should work for cri-o and docker.
> Root is required to access files with any uid/gid.
>
> Dave Gilbert is working on xattr support without CAP_SYS_ADMIN. He may
> be able to find a way to drop unshare (at least in containers).
>
>> "Just" pointing docker to a different seccomp.json file is something whi=
ch
>> k8s users/admin in many cases can't do.
> There is a Moby PR to change the default seccomp.json file here but it's
> unclear if it will be merged:
> https://github.com/moby/moby/pull/41244
>
> Stefan

Why not try Podman?



--JVfEqeD0nAxJkdjLPi5gMzABaO9fQnUzz--

--7d5MUWo1b1wuTpcomcKBEn4YNTtHxYDiS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE+re/ImQyQPB/0p5rot+QHaviwCgFAl8geU0ACgkQot+QHavi
wCgSQggAmSFjOf2uO/6spzwFOUt/cUM1s5pmBtCQt4ZTh6mVbuNZpWKJON9k0mBH
g1y4nZt0kbzH9Mo8Rqmk+/+CbzWMAYlUeAwHSPOXkvErUZQE9oa1Ihs+VjDyd5m8
IWGaJI736purFTQ/tND0erl5KFrUYBzsGTPA+1MFSZJZkZ8PCAkE0/9VkDqjKmXM
g1X4zYKStlmzMhUJ4FL1xnDIpbwiHe4eBVvdJVGUlckaWX6tJWeQBexO+YCzvvMb
BA1pUOIw0E6i3RfCLjhfE8IL1DRCYl1bGW1XNIZ4hdci24tSDhSETAzZMVT+5LYP
LkUkQutB/JSOAWJ2UCN9K8N0N8Fc9Q==
=FTqT
-----END PGP SIGNATURE-----

--7d5MUWo1b1wuTpcomcKBEn4YNTtHxYDiS--



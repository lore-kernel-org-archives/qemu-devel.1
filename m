Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE03FC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A2F2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQqkCbuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A2F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX6J3-0005BN-He
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ldoktor@redhat.com>) id 1iX69X-0001YB-H8
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ldoktor@redhat.com>) id 1iX69V-0001WO-82
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:14:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34411
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1iX69V-0001W8-2W
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574180092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wrXX5N5BM0O5LLyXndNT6VVAGt6Sm+PK2muu7pFq8iQ=;
 b=ZQqkCbuEbcMp8pPIK+rYSYvdSP0EzKYVUprD/Ul0tenQosHF7c52dEVJ9FhnjElHEURCsx
 vwYlFunhoOkad27h9QLYbn0/GbEPvb3CP+c4qqKuTpdUW8ovTN97OO3dRs4UHLKKZc7Cu/
 DiWYF1QO2p4gOl1An1Yq1sQPuc/N97A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-xlDYEG3-OyKaIsuV4Sn60A-1; Tue, 19 Nov 2019 11:13:34 -0500
X-MC-Unique: xlDYEG3-OyKaIsuV4Sn60A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 350E21883522;
 Tue, 19 Nov 2019 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-90.brq.redhat.com
 [10.40.204.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A70381001925;
 Tue, 19 Nov 2019 16:13:30 +0000 (UTC)
Subject: Re: [PATCH] spapr: Fix VSMT mode when it is not supported by the
 kernel
To: Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>
References: <20191108154035.12913-1-lvivier@redhat.com>
 <20191108174759.2d4040f1@bahia.lan> <20191119010012.GI5582@umbus.fritz.box>
 <caa35299-c928-a968-83b5-842d000f0242@redhat.com>
 <20191119164526.0e980a37@bahia.lan>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Autocrypt: addr=ldoktor@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFcV6vsBCADa8NUYov+a+AmCEEUB3stiiMM0NQc1WwlcxGoMxKHcqqIj/kdPhUDvFS32
 V94V7en1Lx+cpXKRMZP3n+3WG+VZWLwaktJgqrECZ161zE7xF5d1H3CLmwStbe6Cw1oR4LYQ
 HBpuqFEA5znoLuTTsP1uXs9h1cYNzX7hmOTvPCLJfDJ1iv954FsgCGtoVvl4CoxaR3u2VNOs
 hXsTTVyJM6gDTsyqn0uvLOHGWGIGVhDkLV4hv6pSdiKrtQKWIUji3Z8x41MbZybmJxHkpOVz
 Jl3jnNE3CbiEq77Is9LMI4yTF2CESs3V4XMBLfZPLrQBC0gzjeRxwCnbdOZRwY5KI457ABEB
 AAG0K0x1a2FzIERva3RvciAoUmVkIEhhdCkgPGxkb2t0b3JAcmVkaGF0LmNvbT6JAVUEEwEC
 AD8CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEF
 AlqVjq0FCQdCCrIACgkQJrNi5H/PIsFF1Qf+K23kB5iOvsbe/swQda9nJZSgKkbXLCF3KCdw
 jCY3qdneHzro696qosRhWn+tpLQ6Mp8sgnXuJk96qaptXtx0R1Ci2oHFo01WfcSLZ1f99/0q
 dWGWJhTt2TPNP6A5rrw//FZlQOYNTYG9vn7euLE0el32ZQp/0HCO7XpLiujEX48fWdlaPmDO
 nalJEpzzJJNu8WnHIG2eLS8lGrNdnPbkxHyeERxPuWDAmHmWyZSaDMtMd40XVKfLfkyY83jz
 +uq8uMxPMzq116YvFygsXqJPgWGYX39BdasEssr/GABHqgKY54dtTdMnFZZFVowkoCSh2Al/
 X/OSk5wpyYZrEYeKNLkBDQRXFer7AQgAw8JIK9pZUfZWNZirBIwOevkdZu1aLhgH84EfXw40
 ynMEFa1t/c0baOiuLNcVbdnHLGvUAQJ2oN/+rdGpEWITVSjDxFYf3JOnySZJhLnQgGMG4j3m
 dFZMubPG1GJEuubPAAB0huRfjQTvOvpIK03J2H5cMoug862OHOnT+mfonGruTkSO0PBq3wtf
 P+Z3gLCuEDkmEZSh4IKxs0CoLU4KxWRQHpoTOxcAiHzj8cm5qbu3Cb1KrXz8dEmYhCq2fpFf
 /h+GfEO8gU/ICJD8WQUHYcVK0bbiZskCcSOGtStjwq0QqitZMbcsPEset/2L3z44MLPuVApv
 c9wORs/3iT9BhwARAQABiQE8BBgBAgAmAhsMFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAlqV
 j3sFCQdCC4AACgkQJrNi5H/PIsG+JAf/emslPCAW4gmn3Ep1ON0V0xPGxFOUbH2m+f079pVP
 Jo3dGT6ZFF8q00GEsqxjpxO/c0opsTFrAN3qyTS3Kr4435ua66J5eP+TBkjN+vljmRi3T9Xg
 h/dHp0JkZQCtcnmNsm/9F0/GzMvc7CnsptDp4aT0KGMfpvv7XrQOkprSr2wgWeAdNVhCP2ZQ
 y+yAzLmHe5OGPW1qPmIBBvEnU2C8av0ONGKIxIAUCF8UCm+YJzPwIwJLhkzrhANiqNwQXwfn
 j8HaEsOCIX26S4GYYmIaY1+GBeHkeh0R/GzERRPh6jfhg2JiCE6ftgZ+DKRjsK3o1uw40aYe
 s/q9jwLlkaqraQ==
Message-ID: <a9974c2c-eea9-4f53-fa4b-4c4ab64a788b@redhat.com>
Date: Tue, 19 Nov 2019 17:13:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119164526.0e980a37@bahia.lan>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="riqBUl0KRnDMd0Ldsy3aL29lz1FLxd7L4"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--riqBUl0KRnDMd0Ldsy3aL29lz1FLxd7L4
Content-Type: multipart/mixed; boundary="H0zXO7LyRaB3H8BJzKex7EMIAPWwm447d"

--H0zXO7LyRaB3H8BJzKex7EMIAPWwm447d
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dne 19. 11. 19 v 16:45 Greg Kurz napsal(a):
> On Tue, 19 Nov 2019 15:06:51 +0100
> Laurent Vivier <lvivier@redhat.com> wrote:
>=20
>> On 19/11/2019 02:00, David Gibson wrote:
>>> On Fri, Nov 08, 2019 at 05:47:59PM +0100, Greg Kurz wrote:
>>>> On Fri,  8 Nov 2019 16:40:35 +0100
>>>> Laurent Vivier <lvivier@redhat.com> wrote:
>>>>
>>>>> Commit 29cb4187497d sets by default the VSMT to smp_threads,
>>>>> but older kernels (< 4.13) don't support that.
>>>>>
>>>>> We can reasonably restore previous behavior with this kernel
>>>>> to allow to run QEMU as before.
>>>>>
>>>>> If VSMT is not supported, VSMT will be set to MAX(8, smp_threads)
>>>>> as it is done for previous machine types (< pseries-4.2)
>>>>>
>>>>
>>>> It is usually _bad_ to base the machine behavior on host capabilities.
>>>> What happens if we migrate between an older kernel and a recent one ?
>>>
>>> Right.  We're really trying to remove instaces of such behaviour.  I'd
>>> prefer to completely revert Greg's original patch than to re-introduce
>>> host configuration dependency into the guest configuration..
>>>
>>>> I understand this is to fix tests/migration-test on older kernels.
>>>> Couldn't this be achieved with migration-test doing some introspection
>>>> and maybe pass vsmt=3D8 on the QEMU command line ?
>>>
>>> ..adjusting the test case like this might be a better idea, though.
>>>
>>> What's the test setup where we're using the old kernel?  I really only
>>> applied the original patch on the guess that we didn't really care
>>> about kernels that old.  The fact you've hit this in practice makes me
>>> doubt that assumption.
>>>
>>
>> The way to fix the tests is to add "-smp threads=3D8" on the command lin=
e
>> (for all tests, so basically in qtest_init_without_qmp_handshake(), and
>> it will impact all the machine types), and we have to check if it is
>=20
> Ohhh... it isn't possible to initialize Qtest with machine specific
> properties ? That's a bit unfortunate :-\
>=20
>> ppc64/pseries to do that, and there it becomes a little bit complicated
>> for a so small piece of code.
>>
>> So I think the best to do is to revert Greg's patch.
>>
>=20
> I'm okay with that since this patch doesn't bring much for the moment.
>=20
> But soon, ie. linux-5.5 hopefully, KVM will allow to configure the number
> of presenters in the XIVE and XICS-on-XIVE devices on POWER9. Combined
> with this patch, it will allow to drastically reduce the consumption of
> resources in the XIVE HW, which currently limits the number of VMs that
> can run concurrently with an in-kernel irqchip. So I hope the 'make check=
'
> you're willing to fix is worth it :-), and BTW you didn't answer David's
> question about the test setup.
>=20

Hello Greg, guys,

it is P8 machine using RHEL7 host with a stock kernel-3.10.0-XXXX. If you'r=
e interested in the whole setup, then:

    ./configure --enable-kvm --block-drv-rw-whitelist=3Dvmdk,null-aio,quoru=
m,null-co,blkverify,file,nbd,raw,blkdebug,host_device,qed,nbd,iscsi,gluster=
,rbd,qcow2,throttle,copy-on-read
    make -j 13
    SPEED=3Dslow make check

Regards,
Luk=E1=9A

> Cheers,
>=20
> --
> Greg
>=20
>> Thanks,
>> Laurent
>>
>=20



--H0zXO7LyRaB3H8BJzKex7EMIAPWwm447d--

--riqBUl0KRnDMd0Ldsy3aL29lz1FLxd7L4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAl3UFKkACgkQJrNi5H/P
IsH55AgAvGCqGNQEaavG6K63y+mpEqPDKCZG+ldRJqqf8n/WfLu4Jk/h8/a/a0p8
Uu0EGVM27QoiRnubpay4sPxe2REUBDQjW0aLaCi73YgZLGb9Gf7CZrXKSK0ISE7c
0b2bfGb1MygqeFeg1WIDiukDg9Dbc+R5MqOqSGesFO8DlMbcuopNzz/V07u+Yb6H
7QUOC0E0i0OInP01PIXKmGe2GAWuy/oQzstlpQ2UiPX/NbbyfeblMoawwA8oQfYL
GCvwB4Gq1NaZ8zzXdHSf0WPjxB8L1o/KYMcd3aNMtzMNKvryVptGK90CcGlmmg+D
a+9JwCgihV6GbasIOfYc5qgQ1BNcCg==
=uj29
-----END PGP SIGNATURE-----

--riqBUl0KRnDMd0Ldsy3aL29lz1FLxd7L4--



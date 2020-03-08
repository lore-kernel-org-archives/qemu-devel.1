Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09721C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 10:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB8F206D7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 10:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHDAdgXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB8F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAt25-0007f2-3X
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 06:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ldoktor@redhat.com>) id 1jAt1L-0007Ei-Eo
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 06:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ldoktor@redhat.com>) id 1jAt1J-0002h7-K4
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 06:18:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41724
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1jAt1J-0002gg-E7
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 06:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583662732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l/gZBAOl1T70WBdoQpOYxTaIvSC9JX/A/zwvNE6430U=;
 b=WHDAdgXw7Nttt+AiXz64BWKdoSwfmEZWctcGahqYUH7lmuFrnY9xmFttjxRYJiIvdfhIip
 +JGlal/IWCUsCHadg00Qs+H35QA2uzHCZL/bDfVnZbthJZ4WJLrHmnLMmpGcewBWloY0qh
 DfvsAXLkYMY+rqp1rwD+elltO09xK6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-Hi8_LClWM1-nChigu1wWSg-1; Sun, 08 Mar 2020 06:18:50 -0400
X-MC-Unique: Hi8_LClWM1-nChigu1wWSg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A14D2100550E
 for <qemu-devel@nongnu.org>; Sun,  8 Mar 2020 10:18:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-205-30.brq.redhat.com
 [10.40.205.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9152D90A0E;
 Sun,  8 Mar 2020 10:18:45 +0000 (UTC)
Subject: Re: [PATCH for-5.0] vl.c: fix migration failure for 3.1 and older
 machine types
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200304172748.15338-1-imammedo@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Autocrypt: addr=ldoktor@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFcV6vsBCADa8NUYov+a+AmCEEUB3stiiMM0NQc1WwlcxGoMxKHcqqIj/kdPhUDvFS32
 V94V7en1Lx+cpXKRMZP3n+3WG+VZWLwaktJgqrECZ161zE7xF5d1H3CLmwStbe6Cw1oR4LYQ
 HBpuqFEA5znoLuTTsP1uXs9h1cYNzX7hmOTvPCLJfDJ1iv954FsgCGtoVvl4CoxaR3u2VNOs
 hXsTTVyJM6gDTsyqn0uvLOHGWGIGVhDkLV4hv6pSdiKrtQKWIUji3Z8x41MbZybmJxHkpOVz
 Jl3jnNE3CbiEq77Is9LMI4yTF2CESs3V4XMBLfZPLrQBC0gzjeRxwCnbdOZRwY5KI457ABEB
 AAG0K0x1a2FzIERva3RvciAoUmVkIEhhdCkgPGxkb2t0b3JAcmVkaGF0LmNvbT6JAVQEEwEI
 AD8CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEF
 Al4caiwFCQsFbrUACgkQJrNi5H/PIsErWAf2OeTv2KSo5ukikdSA/iNItDXqqMhgrN0JbMad
 b82VYKKCFP+NXQy26NQqcKjaJlmv1Q4rYDfLvz+1gvnir6l9gg47g/EPC5s2UxGOlGz8fzgH
 cHne02PFEUKCNSlSZTJW8DCwFKN4VkPGqungJvDd9i8gC9B/TB3HH4IHr82mA3BnQ3wml9KH
 KXRoEJVR15cd6kKU55MRG0mq6VzYnW5Wwyxf0ZC6+R2tQgzxsvxRVPvQXSbcGv3kWoPgRo5a
 8IWzMB194tWVYNaqhMUPKZsgBUGF3JdzrwgDBAuC16mKgyMDrzH3X0ZZ3TXH+mQBXu/px5L8
 BMz/WAibkjPVTeqeuQENBFcV6vsBCADDwkgr2llR9lY1mKsEjA56+R1m7VouGAfzgR9fDjTK
 cwQVrW39zRto6K4s1xVt2ccsa9QBAnag3/6t0akRYhNVKMPEVh/ck6fJJkmEudCAYwbiPeZ0
 Vky5s8bUYkS65s8AAHSG5F+NBO86+kgrTcnYflwyi6DzrY4c6dP6Z+icau5ORI7Q8GrfC18/
 5neAsK4QOSYRlKHggrGzQKgtTgrFZFAemhM7FwCIfOPxybmpu7cJvUqtfPx0SZiEKrZ+kV/+
 H4Z8Q7yBT8gIkPxZBQdhxUrRtuJmyQJxI4a1K2PCrRCqK1kxtyw8Sx63/YvfPjgws+5UCm9z
 3A5Gz/eJP0GHABEBAAGJATwEGAEIACYCGwwWIQSkCkxFxANN4Cpa1IMms2Lkf88iwQUCXhxq
 TwUJCwVutQAKCRAms2Lkf88iwdfeCACyrlND9Kk27optBo2LMBJmoJAOJTl4o8YvWkrGFzK5
 NxWCpaRJCOCfQanACRDW3oEyd4CdLF4GXWsGhIgGymP2+/McpZXJdFwgHNQWtyZ8GHJW/TXr
 GphJ9FLskb2xh83RrLYy29eF+GeZcVLsGP1ZCLz3I6byhbEfklqKymB1q4bQl2cEijm/VK25
 cYpTtNa0SZiNCmfGqfQ60BtDHCjZm1x9GO+67pJmL2FuO0Tq2TtT+SgU1ZKbSYdPWPk2ZetD
 8RRkaPlrVRVGgW1w1/pCS29BHWaazjkmAVHE2Idh6O+7usA/G1Q3OEjWmJpmfwyKHI/rMv/f
 zMoMrrqg5DNH
Message-ID: <3981f062-61ed-10c3-4efa-eb974ec5691f@redhat.com>
Date: Sun, 8 Mar 2020 11:18:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304172748.15338-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CvPp1dBu1SrZh0piRbGc1bqFgxbjIqFqh"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, dgilbert@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CvPp1dBu1SrZh0piRbGc1bqFgxbjIqFqh
Content-Type: multipart/mixed; boundary="86HaUkmX17LaKtbukgDyAuHGWuwrrY1RB"

--86HaUkmX17LaKtbukgDyAuHGWuwrrY1RB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dne 04. 03. 20 v 18:27 Igor Mammedov napsal(a):
> Migration from QEMU(v4.0) fails when using 3.1 or older machine
> type. For example if one attempts to migrate
> QEMU-2.12 started as
>   qemu-system-ppc64 -nodefaults -M pseries-2.12 -m 4096 -mem-path /tmp/
> to current master, it will fail with
>   qemu-system-ppc64: Unknown ramblock "ppc_spapr.ram", cannot accept migr=
ation
>   qemu-system-ppc64: error while loading state for instance 0x0 of device=
 'ram'
>   qemu-system-ppc64: load of migration failed: Invalid argument
>=20
> Caused by 900c0ba373 commit which switches main RAM allocation to
> memory backends and the fact in 3.1 and older QEMU, backends used
> full[***] QOM path as memory region name instead of backend's name.
> That was changed after 3.1 to use prefix-less names by default
> (fa0cb34d22) for new machine types.
> *** effectively makes main RAM memory region names defined by
> MachineClass::default_ram_id being altered with '/objects/' prefix
> and therefore migration fails as old QEMU sends prefix-less
> name while new QEMU expects name with prefix when using 3.1 and
> older machine types.
>=20
> Fix it by forcing implicit[1] memory backend to always use
> prefix-less names for its memory region by setting
>   'x-use-canonical-path-for-ramblock-id'
> property to false.
>=20
> 1) i.e. memory backend created by compat glue which maps
> -m/-mem-path/-mem-prealloc/default RAM size into
> appropriate backend type/options to match old CLI format.
>=20
> Fixes: 900c0ba373
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> ---
> CC: ldoktor@redhat.com
> CC: marcandre.lureau@redhat.com
> CC: dgilbert@redhat.com
> ---
>  softmmu/vl.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 5549f4b619..1101b1cb41 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -2800,6 +2800,9 @@ static void create_default_memdev(MachineState *ms,=
 const char *path)
>      object_property_set_int(obj, ms->ram_size, "size", &error_fatal);
>      object_property_add_child(object_get_objects_root(), mc->default_ram=
_id,
>                                obj, &error_fatal);
> +    /* Ensure backend's memory region name is equal to mc->default_ram_i=
d */
> +    object_property_set_bool(obj, false, "x-use-canonical-path-for-rambl=
ock-id",
> +                             &error_fatal);
>      user_creatable_complete(USER_CREATABLE(obj), &error_fatal);
>      object_unref(obj);
>      object_property_set_str(OBJECT(ms), mc->default_ram_id, "memory-back=
end",
>=20

Tested-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>=20

I can't say anything about the code, but functional-wise it addresses the i=
ssue and fixes post_copy hugepages migration in my mini-CI (variants 2.10, =
2.12, 3.0, 3.1, 4.0 -> master and vice-versa are failing with master and pa=
ssing with this patch).

Regards,
Luk=C3=A1=C5=A1


--86HaUkmX17LaKtbukgDyAuHGWuwrrY1RB--

--CvPp1dBu1SrZh0piRbGc1bqFgxbjIqFqh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAl5kxoQACgkQJrNi5H/P
IsFezgf7BE8uMGMiT++2yxlXzuB0PylTsBIuU/c3fMZNXqdWUVfiONLi4YVDjZ9x
FqYHAHSBRXHuyUaQPtJcy+qoDw69HArbHiV62mGVyMYVN8vSz+PdLqKkZMeCujzJ
DVUYr4okD1a3vteOzpvkkMvzrV9OnyJHGz/u+nJjSZM3b3J93N+Usauw5LbkcN/U
6SH6isC6xyA0p4xuEfVgetlweGO0bddkTs1l9CjG88RBRcBOCb87LV87OcqhbT7l
vmFx+vvw1Ukmn4XZaBGLAbMzWxVVlUaB1fX2hqb6v19vWsC9BDJxfbB0h0Y9DWdv
F25dhf8579/tPJWoBQgc2GV3J0Z2Kw==
=qf45
-----END PGP SIGNATURE-----

--CvPp1dBu1SrZh0piRbGc1bqFgxbjIqFqh--



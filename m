Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FA9C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3C9207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3C9207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCP9G-0007kg-J9
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iCP6u-0006Um-F7
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iCP6t-0006QF-61
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:14:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iCP6p-0006PU-Qh; Mon, 23 Sep 2019 10:14:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 21C5410CC1FA;
 Mon, 23 Sep 2019 14:14:35 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 901BB5D9D5;
 Mon, 23 Sep 2019 14:14:30 +0000 (UTC)
Subject: Re: [PATCH] nbd: Grab aio context lock in more places
To: Sergio Lopez <slp@redhat.com>
References: <20190917023917.32226-1-eblake@redhat.com>
 <87d0frcdd8.fsf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <821c8483-44b0-0c6b-12af-f72984ed19ff@redhat.com>
Date: Mon, 23 Sep 2019 09:14:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87d0frcdd8.fsf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dlckrLlSNZ7RQRAZZrCOTQ4Kvu9ebc9HA"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Mon, 23 Sep 2019 14:14:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dlckrLlSNZ7RQRAZZrCOTQ4Kvu9ebc9HA
Content-Type: multipart/mixed; boundary="AbWWABeXBqQlcE8lWJEbuuBYQefpRQ8vk";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Message-ID: <821c8483-44b0-0c6b-12af-f72984ed19ff@redhat.com>
Subject: Re: [PATCH] nbd: Grab aio context lock in more places
References: <20190917023917.32226-1-eblake@redhat.com>
 <87d0frcdd8.fsf@redhat.com>
In-Reply-To: <87d0frcdd8.fsf@redhat.com>

--AbWWABeXBqQlcE8lWJEbuuBYQefpRQ8vk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/23/19 9:10 AM, Sergio Lopez wrote:
>=20
> Eric Blake <eblake@redhat.com> writes:
>=20
>> When iothreads are in use, the failure to grab the aio context results=

>> in an assertion failure when trying to unlock things during blk_unref,=

>> when trying to unlock a mutex that was not locked.  In short, all
>> calls to nbd_export_put need to done while within the correct aio
>> context.  But since nbd_export_put can recursively reach itself via
>> nbd_export_close, and recursively grabbing the context would deadlock,=

>> we can't do the context grab directly in those functions, but must do
>> so in their callers.
>>
>> Hoist the use of the correct aio_context from nbd_export_new() to its
>> caller qmp_nbd_server_add().  Then tweak qmp_nbd_server_remove(),
>> nbd_eject_notifier(), and nbd_esport_close_all() to grab the right
>> context, so that all callers during qemu now own the context before
>> nbd_export_put() can call blk_unref().
>>
>> Remaining uses in qemu-nbd don't matter (since that use case does not
>> support iothreads).
>>
>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> With this in place, my emailed formula [1] for causing an iothread
>> assertion failure no longer hits, and all the -nbd and -qcow2 iotests
>> still pass.  I would still like to update iotests to cover things (I
>> could not quickly figure out how to make iotest 222 use iothreads -
>> either we modify that one or add a new one), but wanted to get review
>> started on this first.
>>
>> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03383.htm=
l

I ended up patch 223 instead, as patch 2/1 in reply to the original.


>>  void nbd_export_close(NBDExport *exp)
>>  {
>>      NBDClient *client, *next;
>>
>>      nbd_export_get(exp);
>> +
>=20
> I'm not sure if this new line was added here on purpose.
>=20

Spurious leftovers from an alternative attempt.  Will drop this.

>>      /*
>>       * TODO: Should we expand QMP NbdServerRemoveNode enum to allow a=

>>       * close mode that stops advertising the export to new clients bu=
t
>> @@ -1684,9 +1695,13 @@ BlockBackend *nbd_export_get_blockdev(NBDExport=
 *exp)
>>  void nbd_export_close_all(void)
>>  {
>>      NBDExport *exp, *next;
>> +    AioContext *aio_context;
>>
>>      QTAILQ_FOREACH_SAFE(exp, &exports, next, next) {
>> +        aio_context =3D exp->ctx;
>> +        aio_context_acquire(aio_context);
>>          nbd_export_close(exp);
>> +        aio_context_release(aio_context);
>>      }
>>  }
>=20
> Otherwise, LGTM.
>=20
> Reviewed-by: Sergio Lopez <slp@redhat.com>
>=20

Thanks; queuing this on my NBD tree, along with the iotest followup
(although there's still a bit of time for that to get a review before I
send the pull request later today).


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--AbWWABeXBqQlcE8lWJEbuuBYQefpRQ8vk--

--dlckrLlSNZ7RQRAZZrCOTQ4Kvu9ebc9HA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2I00UACgkQp6FrSiUn
Q2p5rgf/XEUgkiZzu29JtqSAzXx0FZrLIQGHKfat0SXCDbb5KAPaGjcanEhPz3ye
2GL8bDhRnYiRMxHPTlStWJsDlWKkMwlPtjYAQEEhg6h4mnpCnykGdqCunnCqo8gY
4yCTC9O3XcHG44EyFKdvltK7qQP2MtR5t4aXa7gzOq0b7HdqYJE7p2mdgNKnHCBg
0P2exSVhNDZFHsJrm137vSUGxM0fPLdfJhb70RcTgYfHsV+nudF8n0XpROckiR75
KwwNdBowfjpaAnSAmTsWg08ZfLA97z1OlRZZgmHf7S27iVP4k71hx4X6BBocLuVE
dMmM43xGFCSmP67YEkDpPjqn+NfsCg==
=GTVp
-----END PGP SIGNATURE-----

--dlckrLlSNZ7RQRAZZrCOTQ4Kvu9ebc9HA--


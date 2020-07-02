Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0578DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB98C2073E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUWuFWaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB98C2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqta1-0007ow-Tp
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 03:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqtZR-0007Mg-57
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 03:23:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47228
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqtZO-0006Zm-Bk
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 03:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593674620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=m6qJSQ9ruIQIHyR+6fae/B+lJw1+iw6u5iX59jdqocg=;
 b=VUWuFWaDMGZlxd4dWyFPI8f1VbdduplhQpcOwYUkhEWJDGZu9lQsyGmLAJKvmHo4lv4tH9
 Nb12WivMddfDsBOUt6GgqKOoTuNWgDRdSlSOZFCoNSMFoZcpMxEh5P2jyTuKxx37xTwP7k
 5P1wtcku26dBz+XsEz8eGA/1eAJkDuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-8SdoRSReNnSKG0Q79vLn7Q-1; Thu, 02 Jul 2020 03:23:38 -0400
X-MC-Unique: 8SdoRSReNnSKG0Q79vLn7Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07DB3107ACCD;
 Thu,  2 Jul 2020 07:23:37 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-196.ams2.redhat.com
 [10.36.113.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A37465DAB0;
 Thu,  2 Jul 2020 07:23:35 +0000 (UTC)
Subject: Re: Properly quitting qemu immediately after failing migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <0dce6c63-4b83-8b1a-6d00-07235f637997@redhat.com>
 <92ce741d-ef67-fbf9-a889-27d9ae218681@virtuozzo.com>
 <9eecca93-e7d9-d1da-7fcd-ee60978ec460@redhat.com>
 <61a5c813-d638-3e03-05a6-a7b0c27cc834@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <f166c770-7c5d-2854-1dfe-3a69300eca5f@redhat.com>
Date: Thu, 2 Jul 2020 09:23:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <61a5c813-d638-3e03-05a6-a7b0c27cc834@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="skHIvS83siljvrugSsToSmdNStANrnnUZ"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--skHIvS83siljvrugSsToSmdNStANrnnUZ
Content-Type: multipart/mixed; boundary="iq6YknIPQInWoWcQu84YCXHav7w7CmsWg"

--iq6YknIPQInWoWcQu84YCXHav7w7CmsWg
Content-Type: multipart/mixed;
 boundary="------------0B3E9A25C4774B20FB58C572"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0B3E9A25C4774B20FB58C572
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.07.20 18:16, Vladimir Sementsov-Ogievskiy wrote:
> 29.06.2020 18:00, Max Reitz wrote:
>> On 29.06.20 16:18, Vladimir Sementsov-Ogievskiy wrote:
>>> 29.06.2020 16:48, Max Reitz wrote:
>>>> Hi,
>>>>
>>>> In an iotest, I=E2=80=99m trying to quit qemu immediately after a migr=
ation has
>>>> failed.=C2=A0 Unfortunately, that doesn=E2=80=99t seem to be possible =
in a clean
>>>> way:
>>>> migrate_fd_cleanup() runs only at some point after the migration state
>>>> is already =E2=80=9Cfailed=E2=80=9D, so if I just wait for that =E2=80=
=9Cfailed=E2=80=9D state and
>>>> immediately quit, some cleanup functions may not have been run yet.
>>>>
>>>> This is a problem with dirty bitmap migration at least, because it
>>>> increases the refcount on all block devices that are to be migrated, s=
o
>>>> if we don=E2=80=99t call the cleanup function before quitting, the ref=
count
>>>> will
>>>> stay elevated and bdrv_close_all() will hit an assertion because those
>>>> block devices are still around after blk_remove_all_bs() and
>>>> blockdev_close_all_bdrv_states().
>>>>
>>>> In practice this particular issue might not be that big of a problem,
>>>> because it just means qemu aborts when the user intended to let it qui=
t
>>>> anyway.=C2=A0 But on one hand I could imagine that there are other cle=
an-up
>>>> paths that should definitely run before qemu quits (although I don=E2=
=80=99t
>>>> know), and on the other, it=E2=80=99s a problem for my test.
>>>>
>>>> I tried working around the problem for my test by waiting on =E2=80=9C=
Unable to
>>>> write=E2=80=9D appearing on stderr, because that indicates that
>>>> migrate_fd_cleanup()=E2=80=99s error_report_err() has been reached.=C2=
=A0 But on one
>>>> hand, that isn=E2=80=99t really nice, and on the other, it doesn=E2=80=
=99t even work
>>>> when the failure is on the source side (because then there is no
>>>> s->error for migrate_fd_cleanup() to report).
>>
>> (I=E2=80=99ve now managed to work around it by invoking blockdev-del on =
a node
>> affected by bitmap migration until it succeeds, because blockdev-del can
>> only succeed once the bitmap migration code has dropped its reference to
>> it.)
>>
>>>> In all, I=E2=80=99m asking:
>>>> (1) Is there a nice solution for me now to delay quitting qemu until
>>>> the
>>>> failed migration has been fully resolved, including the clean-up?
>>>>
>>>> (2) Isn=E2=80=99t it a problem if qemu crashes when you issue =E2=80=
=9Cquit=E2=80=9D via QMP at
>>>> the wrong time?=C2=A0 Like, maybe lingering subprocesses when using =
=E2=80=9Cexec=E2=80=9D?
>>>>
>>>>
>>>
>>> I'll look more closely tomorrow, but as a short answer: try my series
>>> "[PATCH v2 00/22] Fix error handling during bitmap postcopy" it
>>> handles different problems around migration failures & qemu shutdown,
>>> probably it will help.
>>
>> Not, it doesn=E2=80=99t seem to.
>>
>> I=E2=80=99m not sure what exactly that series addresses, but FWIW I=E2=
=80=99m hitting
>> the problem in non-postcopy migration.=C2=A0 What my simplest reproducer
>> does is:
>=20
> Bitmaps migration is postcopy by nature (and it may not work without
> migrate-start-postcopy, but work in most simple cases, as when we have
> small bitmap data to migrate, it can migrate during migration downtime).
> Most complicated part of the series were about postcopy. Still it fixes
> some other things.
>=20
> It seems, that patch (see the second paragraph)
> "[PATCH v2 10/22] migration/block-dirty-bitmap: cancel migration on
> shutdown"
>=20
>> =C2=A0=C2=A0 If target is turned of prior to postcopy finished, target c=
rashes
>> =C2=A0=C2=A0 because busy bitmaps are found at shutdown.
>> =C2=A0=C2=A0 Canceling incoming migration helps, as it removes all unfin=
ished (and
>> =C2=A0=C2=A0 therefore busy) bitmaps.
>=20
>> =C2=A0=C2=A0 Similarly on source we crash in bdrv_close_all which assert=
s that all
>> =C2=A0=C2=A0 bdrv states are removed, because bdrv states involved into =
dirty
>> bitmap
>> =C2=A0=C2=A0 migration are referenced by it. So, we need to cancel outgo=
ing
>> =C2=A0=C2=A0 migration as well.
> =C2=A0=C2=A0=C2=A0 should address exactly your issue.

Hm.  I=E2=80=99ve tested your series and still hit the issue.

I could imagine that my problem lies with a failed migration that is
automatically =E2=80=9Ccancelled=E2=80=9D by nature, so the problem isn=E2=
=80=99t that it isn=E2=80=99t
cancelled, but that the clean-up runs after accepting further QMP
commands (like quit).

>>
>> On the source VM:
>>
>> blockdev-add node-name=3D'foo' driver=3D'null-co'
>> block-dirty-bitmap-add node=3D'foo' name=3D'bmap0'
>>
>> (Launch destination VM with some -incoming, e.g.
>> -incoming 'exec: cat /tmp/mig_file')
>>
>> Both on source and destination:
>>
>> migrate-set-capabilities capabilities=3D[
>> =C2=A0=C2=A0=C2=A0=C2=A0 {capability=3D'events', state=3Dtrue},
>> =C2=A0=C2=A0=C2=A0=C2=A0 {capability=3D'dirty-bitmaps', state=3Dtrue}
>> ]
>>
>> On source:
>>
>> migrate uri=3D'exec: cat > /tmp/mig_file'
>>
>> Then wait for a MIGRATION event with data/status =3D=3D 'failed', and th=
en
>> issue 'quit'.
>>
>> Max
>>
>=20
> Can you post exact reproducer iotest?

I didn=E2=80=99t have an iotest until now (because it was a simple test wri=
tten
up in Ruby), but what I=E2=80=99ve attached should work.

Note that you need system load to trigger the problem (or the clean-up
code is scheduled too quickly), so I usually just run like three
instances concurrently.

(while TEST_DIR=3D/tmp/t$i ./check 400; do; done)

Max

--------------0B3E9A25C4774B20FB58C572
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Quit-crash-reproducer.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-Quit-crash-reproducer.patch"

From ce0cacd21058f27fcb18aa632bfd5bc4fb3feadf Mon Sep 17 00:00:00 2001
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 2 Jul 2020 09:21:14 +0200
Subject: [PATCH] Quit crash reproducer

---
 tests/qemu-iotests/400     | 42 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/400.out |  5 +++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 48 insertions(+)
 create mode 100755 tests/qemu-iotests/400
 create mode 100644 tests/qemu-iotests/400.out

diff --git a/tests/qemu-iotests/400 b/tests/qemu-iotests/400
new file mode 100755
index 0000000000..a32b2c3064
--- /dev/null
+++ b/tests/qemu-iotests/400
@@ -0,0 +1,42 @@
+#!/usr/bin/env python3
+
+import os
+import iotests
+
+mig_sock =3D os.path.join(iotests.sock_dir, 'mig.sock')
+
+class TestMigQuit(iotests.QMPTestCase):
+    def setUp(self):
+        self.vm_a =3D iotests.VM(path_suffix=3D'a')
+        self.vm_a.launch()
+
+        self.vm_a.qmp('blockdev-add', node_name=3D'foo', driver=3D'null-co=
')
+        self.vm_a.qmp('block-dirty-bitmap-add', node=3D'foo', name=3D'bmap=
0')
+
+        self.vm_b =3D iotests.VM(path_suffix=3D'b')
+        self.vm_b.add_incoming(f'unix:{mig_sock}')
+        self.vm_b.launch()
+
+        for vm in (self.vm_a, self.vm_b):
+            vm.qmp('migrate-set-capabilities',
+                    capabilities=3D[{'capability': 'events', 'state': True=
},
+                                  {'capability': 'dirty-bitmaps',
+                                   'state': True}])
+
+    def tearDown(self):
+        self.vm_a.shutdown()
+        self.vm_b.shutdown()
+
+        try:
+            os.remove(mig_sock)
+        except OSError:
+            pass
+
+    def test_mig_quit(self):
+        self.vm_a.qmp('migrate', uri=3Df'unix:{mig_sock}')
+
+        while self.vm_a.event_wait('MIGRATION')['data']['status'] !=3D 'fa=
iled':
+            pass
+
+if __name__ =3D=3D '__main__':
+    iotests.main()
diff --git a/tests/qemu-iotests/400.out b/tests/qemu-iotests/400.out
new file mode 100644
index 0000000000..ae1213e6f8
--- /dev/null
+++ b/tests/qemu-iotests/400.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index d886fa0cb3..cdb785b034 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -302,3 +302,4 @@
 291 rw quick
 292 rw auto quick
 297 meta
+400
--=20
2.26.2


--------------0B3E9A25C4774B20FB58C572--

--iq6YknIPQInWoWcQu84YCXHav7w7CmsWg--

--skHIvS83siljvrugSsToSmdNStANrnnUZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl79i3UACgkQ9AfbAGHV
z0Drfgf/VueNyNTkzrnPUjMFTAr/nMyeBqSREP5HTEq6JtS4JYsWWwpXjoNSgMMG
+E0OJCKfpiIbBAahiAYLKIPYo2KSJAvHO7Blt4W0gUXTELu5FiutaQRMULyYFq5Y
gsn+10LYpRReJOyo6klrEnB8OPMFLbopgBTP01eS33/SI3ktSW80BYEtYp1Ae57R
LXxh+i50LQBge5I8gZYjoro+WJSjZkT8QhHFRiuBDBNg3H+KF0Vb2gWrkjCZwMnL
xfKtxKesuZJP89t/3uWvY4ZK/GkO2I9y3PY9261ZqcoSuTPpjXrBOUCTOp1F0Eje
HdNqVqPl6qQS4x4aYHrpJXEAKcsVAA==
=/KK1
-----END PGP SIGNATURE-----

--skHIvS83siljvrugSsToSmdNStANrnnUZ--



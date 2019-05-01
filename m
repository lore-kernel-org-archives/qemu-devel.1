Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A3BC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 16:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78467217D7
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 16:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78467217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35887 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLryb-0002ie-KG
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 12:20:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hLrxg-0002Cn-I3
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hLrxd-00041V-H8
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:20:00 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:55820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brogers@suse.com>) id 1hLrxd-0003ZC-8S
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:19:57 -0400
Received: from INET-PRV-MTA by prv-mh.provo.novell.com
	with Novell_GroupWise; Wed, 01 May 2019 10:19:46 -0600
Message-Id: <5CC9C785020000480009D9AB@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date: Wed, 01 May 2019 10:21:25 -0600
From: "Bruce Rogers" <brogers@suse.com>
To: <qemu-devel@nongnu.org>,<jsnow@redhat.com>
References: <20190430131946.26628-1-brogers@suse.com>
	<4361ed56-ff32-7f89-4e1a-173898e8081a@redhat.com>
In-Reply-To: <4361ed56-ff32-7f89-4e1a-173898e8081a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 137.65.248.74
Subject: Re: [Qemu-devel] [PATCH v2] scsi-disk: handle invalid cdb length
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "fam@euphon.net" <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501162125.__ADNPiLf19A4nc-I93kNJgsYAU3MDJKnXA6jKBZmcY@z>

>>> On 4/30/2019 at 2:40 PM, John Snow <jsnow@redhat.com> wrote:

>=20
> On 4/30/19 9:19 AM, Bruce Rogers wrote:
>> While investigating link-time-optimization, the compiler flagged this
>> case of not handling the error return from scsi_cdb_length(). Handle
>> this error case with a trace report.
>>=20
>> Signed-off-by: Bruce Rogers <brogers@suse.com>
>> ---
>>  hw/scsi/scsi-disk.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>=20
>> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
>> index e7e865ab3b..8fbf7512e5 100644
>> --- a/hw/scsi/scsi-disk.c
>> +++ b/hw/scsi/scsi-disk.c
>> @@ -2520,6 +2520,10 @@ static void scsi_disk_new_request_dump(uint32_t =
lun,=20
> uint32_t tag, uint8_t *buf)
>>      int len =3D scsi_cdb_length(buf);
>>      char *line_buffer, *p;
>> =20
>> +    if (len < 0) {
>> +        trace_scsi_disk_new_request(lun, tag, "bad cdb length");
>=20
> This is going to print:
>=20
> "Command: lun=3D%d tag=3D0x%x data=3Dbad cdb length"
>=20
> which is maybe not the best. I'd rather print something more direct, but
> it's probably better than actually rolling forward with len =3D -1.
>=20
> Then again, this should literally never happen, because scsi_req_new is
> parsing the cdb object and already rejecting such cases.
>=20

Indeed, that is true.


> Can you satisfy the compiler by asserting that it is greater than zero?
> It ought to be provably true.

Yes, that seems to work and is probably the way to go. I'll send a patch
with that approach then. Thanks for the review.

>=20
> --js
>=20
>> +        return;
>> +    }
>>      line_buffer =3D g_malloc(len * 5 + 1);
>> =20
>>      for (i =3D 0, p =3D line_buffer; i < len; i++) {
>>=20

Bruce



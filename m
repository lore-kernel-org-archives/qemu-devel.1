Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BCEC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 02:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FA52147A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 02:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FA52147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37776 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLI7t-0006mX-Tx
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 22:04:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hLI6o-00067T-PS
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 22:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hLI6n-0000iM-Ez
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 22:03:02 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:34188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brogers@suse.com>) id 1hLI6m-0000gw-Ve
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 22:03:01 -0400
Received: from INET-PRV-MTA by prv-mh.provo.novell.com
	with Novell_GroupWise; Mon, 29 Apr 2019 20:02:55 -0600
Message-Id: <5CC7AD36020000480009D802@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date: Mon, 29 Apr 2019 20:04:38 -0600
From: "Bruce Rogers" <brogers@suse.com>
To: <qemu-devel@nongnu.org>,<eblake@redhat.com>
References: <20190429235109.20307-1-brogers@suse.com>
	<3dd36ff4-b51f-fde0-7665-f9ad4eda9194@redhat.com>
In-Reply-To: <3dd36ff4-b51f-fde0-7665-f9ad4eda9194@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 137.65.248.74
Subject: Re: [Qemu-devel] [PATCH] scsi-disk: handle invalid cdb length
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
Message-ID: <20190430020438.nTuEKK65_TgssgSUB7qzfcEwhYJgrAYkHQs_D1dkWGQ@z>

>>> On 4/29/2019 at 7:37 PM, Eric Blake <eblake@redhat.com> wrote:
> On 4/29/19 6:51 PM, Bruce Rogers wrote:
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
>> index e7e865ab3b..dc13c892ef 100644
>> --- a/hw/scsi/scsi-disk.c
>> +++ b/hw/scsi/scsi-disk.c
>> @@ -2520,6 +2520,10 @@ static void scsi_disk_new_request_dump(uint32_t =
lun,=20
> uint32_t tag, uint8_t *buf)
>>      int len =3D scsi_cdb_length(buf);
>>      char *line_buffer, *p;
>> =20
>> +    if (len < 0) {
>> +        trace_scsi_disk_new_request(lun, tag, "bad cdb length!");
>=20
> I'd drop the !. We aren't shouting at the trace clients, after all :)

Got it.

Bruce



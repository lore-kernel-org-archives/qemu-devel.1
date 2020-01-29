Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E41C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1352070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewfMHOKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1352070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwkag-0007UA-Uh
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 05:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iwkZv-0006yO-2n
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iwkZt-0001Hp-Rr
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:28:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37881
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iwkZt-0001HA-Ot
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580293688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Yn/biW5KnVntJ9hcY0ZTLnTXCxNNVrvJHWnhNO2NVs=;
 b=ewfMHOKffrNNy8/tTC/6cwZVc2tT7fq/vtAZhRo8W8beQP6Raz7fZW7JgKYHk5Q0kcxahW
 Z3Tp3fFAaB5J5XKlZNEdLORpOPyvMN3msH1t6rGaRYiuEH70Zy/5EQQxEV1+s351XHpBGU
 yWgCFmUu+lhjZa3Kl0I4TMxQtTGM518=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-IIce76GfNSGViItLGzpcjw-1; Wed, 29 Jan 2020 05:28:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C740318C43C9;
 Wed, 29 Jan 2020 10:28:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C19A35C219;
 Wed, 29 Jan 2020 10:27:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5495D1138404; Wed, 29 Jan 2020 11:27:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 13/13] monitor/hmp: Prefer to use hmp_handle_error for
 error reporting in block hmp commands
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <20200127103647.17761-14-mlevitsk@redhat.com>
 <f6c782743639a93ac06c8a6ef0e110b66eb613c4.camel@redhat.com>
Date: Wed, 29 Jan 2020 11:27:57 +0100
In-Reply-To: <f6c782743639a93ac06c8a6ef0e110b66eb613c4.camel@redhat.com>
 (Maxim Levitsky's message of "Tue, 28 Jan 2020 21:31:27 +0200")
Message-ID: <87eevi7e1e.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: IIce76GfNSGViItLGzpcjw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Mon, 2020-01-27 at 12:36 +0200, Maxim Levitsky wrote:
>> This way they all will be prefixed with 'Error:' which some parsers
>> (e.g libvirt) need
>>=20
>> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1719169
>>=20
>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>
> And I probably will keep that patch since it is not invasive and
> still does a nice refactoring.
> Thoughts?

The commit message needs updating: libvirt doesn't actually need this
anymore.

What remains is "nice refactoring".  Let's look at the patch from that
perspective.

>
> Best regards,
> =09Maxim Levitsky
>
>> ---
>>  block/monitor/block-hmp-cmds.c | 35 ++++++++++++++++++++--------------
>>  1 file changed, 21 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cm=
ds.c
>> index 7bbe4e3814..5b060d380d 100644
>> --- a/block/monitor/block-hmp-cmds.c
>> +++ b/block/monitor/block-hmp-cmds.c
>> @@ -84,7 +84,6 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict)
>>      mc =3D MACHINE_GET_CLASS(current_machine);
>>      dinfo =3D drive_new(opts, mc->block_default_type, &err);
>>      if (err) {
>> -        error_report_err(err);
>>          qemu_opts_del(opts);
>>          goto err;
>>      }
>> @@ -98,7 +97,7 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict)
>>          monitor_printf(mon, "OK\n");
>>          break;
>>      default:
>> -        monitor_printf(mon, "Can't hot-add drive to type %d\n", dinfo->=
type);
>> +        error_setg(&err, "Can't hot-add drive to type %d", dinfo->type)=
;
>>          goto err;
>>      }
>>      return;
>> @@ -109,6 +108,7 @@ err:
>>          monitor_remove_blk(blk);
>>          blk_unref(blk);
>>      }
>> +    hmp_handle_error(mon, err);
>>  }

Is this really nicer?

>> =20
>>  void hmp_drive_del(Monitor *mon, const QDict *qdict)
>> @@ -130,14 +130,14 @@ void hmp_drive_del(Monitor *mon, const QDict *qdic=
t)
>> =20
>>      blk =3D blk_by_name(id);
>>      if (!blk) {
>> -        error_report("Device '%s' not found", id);
>> -        return;
>> +        error_setg(&local_err, "Device '%s' not found", id);
>> +        goto err;
>>      }
>> =20
>>      if (!blk_legacy_dinfo(blk)) {
>> -        error_report("Deleting device added with blockdev-add"
>> -                     " is not supported");
>> -        return;
>> +        error_setg(&local_err,
>> +                   "Deleting device added with blockdev-add is not supp=
orted");
>> +        goto err;
>>      }
>> =20
>>      aio_context =3D blk_get_aio_context(blk);
>> @@ -146,9 +146,8 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
>>      bs =3D blk_bs(blk);
>>      if (bs) {
>>          if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_DRIVE_DEL, &local_err)=
) {
>> -            error_report_err(local_err);
>>              aio_context_release(aio_context);
>> -            return;
>> +            goto err;
>>          }
>> =20
>>          blk_remove_bs(blk);
>> @@ -169,12 +168,15 @@ void hmp_drive_del(Monitor *mon, const QDict *qdic=
t)
>>      }
>> =20
>>      aio_context_release(aio_context);
>> +err:
>> +    hmp_handle_error(mon, local_err);
>>  }

Likewise.

>> =20
>>  void hmp_commit(Monitor *mon, const QDict *qdict)
>>  {
>>      const char *device =3D qdict_get_str(qdict, "device");
>>      BlockBackend *blk;
>> +    Error *local_err =3D NULL;
>>      int ret;
>> =20
>>      if (!strcmp(device, "all")) {
>> @@ -185,12 +187,12 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
>> =20
>>          blk =3D blk_by_name(device);
>>          if (!blk) {
>> -            error_report("Device '%s' not found", device);
>> -            return;
>> +            error_setg(&local_err, "Device '%s' not found", device);
>> +            goto err;
>>          }
>>          if (!blk_is_available(blk)) {
>> -            error_report("Device '%s' has no medium", device);
>> -            return;
>> +            error_setg(&local_err, "Device '%s' has no medium", device)=
;
>> +            goto err;
>>          }
>> =20
>>          bs =3D blk_bs(blk);
>> @@ -202,8 +204,13 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
>>          aio_context_release(aio_context);
>>      }
>>      if (ret < 0) {
>> -        error_report("'commit' error for '%s': %s", device, strerror(-r=
et));
>> +        error_setg(&local_err,
>> +                   "'commit' error for '%s': %s", device, strerror(-ret=
));
>> +        goto err;
>>      }
>> +    return;
>> +err:
>> +    hmp_handle_error(mon, local_err);
>>  }
>> =20
>>  void hmp_drive_mirror(Monitor *mon, const QDict *qdict)

Likewise.

Up to the code's maintainers Kevin & Max.



Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B640C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:45:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7E421556
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbR8qUZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7E421556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir01o-0007Ei-Qz
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 08:45:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ir00v-0006U0-9v
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:44:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ir00t-0005Gp-5C
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:44:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59152
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ir00t-0005EP-1K
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578923054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dN/yPyoFMeDL81OcuZj8le7+MM3kYXIME8a+Apfxzw=;
 b=XbR8qUZ6mx5w4K2GOdlHea2eb9RfW+iqg2zO3Hafn482aMvQNK/qCpNgBYRT9Y5Rpwcv4V
 XZPg5CMX4GKh6VW/y1TEEbdZvTfxgszOekoF93RZJBV+XLb1uraB7xuysXPbFQeGZctJPL
 BMi7VINlpcd0/KuazfO0pcl4GexNOI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-UN7SW-qCPP2ZzZOmaR1P1A-1; Mon, 13 Jan 2020 08:44:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76993107B288;
 Mon, 13 Jan 2020 13:44:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F51419C6A;
 Mon, 13 Jan 2020 13:44:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 925691138600; Mon, 13 Jan 2020 14:44:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org> <20200102150501.GA2973@work-vm>
Date: Mon, 13 Jan 2020 14:44:00 +0100
In-Reply-To: <20200102150501.GA2973@work-vm> (David Alan Gilbert's message of
 "Thu, 2 Jan 2020 15:05:01 +0000")
Message-ID: <87blr7zd27.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: UN7SW-qCPP2ZzZOmaR1P1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> Stefan Hajnoczi <stefanha@gmail.com> writes:
>> > 4. Go and Rust bindings would also be useful.  There is
>> > https://github.com/intel/govmm but I think it makes sense to keep it
>> > in qemu.git and provide an interface similar to our Python modules.
>>=20
>> Mapping QAPI/QMP commands and events to function signatures isn't hard
>> (the QAPI code generator does).  Two problems (at least):
>>=20
>> 1. Leads to some pretty ridiculous functions.  Here's one:
>>=20
>>     void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
>>                              const char *device,
>>                              const char *target,
>>                              bool has_replaces, const char *replaces,
>>                              MirrorSyncMode sync,
>>                              bool has_speed, int64_t speed,
>>                              bool has_granularity, uint32_t granularity,
>>                              bool has_buf_size, int64_t buf_size,
>>                              bool has_on_source_error,
>>                              BlockdevOnError on_source_error,
>>                              bool has_on_target_error, BlockdevOnError o=
n_target_error,
>>                              bool has_filter_node_name, const char *filt=
er_node_name,
>>                              bool has_copy_mode, MirrorCopyMode copy_mod=
e,=20
>>                              bool has_auto_finalize, bool auto_finalize,
>>                              bool has_auto_dismiss, bool auto_dismiss,
>>                              Error **errp);
>
> Those might not be as bad when mapped to other languages, all the
> bool/value pairs would become Option<...>  so that removes that doubling.
> The Error ** mechanism should somehow map onto functions returning a
> normal Rust Result<> type.

Fifteen parameters even with the has_FOO and the errp dropped.
Still ridiculous enough for me.



Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6721BC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD141208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEX3go13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD141208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVvzn-0001L8-MR
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kVvyY-0000l4-Hz
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kVvyW-0000Wy-C0
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603455315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVZGiUqo+OOse7/MeaEs/I2zhtE68Z6khl47Gyf09W0=;
 b=CEX3go13o1VeuWMeC5ydSZbH4YuTSjkl/lZR+Xz1f4yezk5t6oKmC6mTJ+V7u6fJgntLTS
 7GDQHtttBTEAnlNQmLZi7hDJrlNut7XqoFQlNZCk+S8hZ1Gty7WmmSLu9yDmykeCdelVNI
 1jeMgp8uygLoS2IpjJS62oVsclo3L+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-Atq_MM8yNq2kc0CoX8EYug-1; Fri, 23 Oct 2020 08:15:13 -0400
X-MC-Unique: Atq_MM8yNq2kc0CoX8EYug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4598E188C127;
 Fri, 23 Oct 2020 12:15:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 160CD6EF5D;
 Fri, 23 Oct 2020 12:15:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BE748113865F; Fri, 23 Oct 2020 14:15:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 2/6] char: Factor out qemu_chr_print_types()
References: <20201023101222.250147-1-kwolf@redhat.com>
 <20201023101222.250147-3-kwolf@redhat.com>
 <CAJ+F1C+s8cYgL20PXe2yRrC2jjpW+ANW215o4Z6jCgrkOewkZw@mail.gmail.com>
Date: Fri, 23 Oct 2020 14:15:10 +0200
In-Reply-To: <CAJ+F1C+s8cYgL20PXe2yRrC2jjpW+ANW215o4Z6jCgrkOewkZw@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 23 Oct 2020
 14:38:58 +0400")
Message-ID: <878sbxqgtt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> On Fri, Oct 23, 2020 at 2:14 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
>> We'll want to call the same from a non-QemuOpts code path.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  include/chardev/char.h |  1 +
>>  chardev/char.c         | 17 +++++++++++------
>>  2 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/chardev/char.h b/include/chardev/char.h
>> index db42f0a8c6..3b91645081 100644
>> --- a/include/chardev/char.h
>> +++ b/include/chardev/char.h
>> @@ -212,6 +212,7 @@ void qemu_chr_be_update_read_handlers(Chardev *s,
>>   */
>>  void qemu_chr_be_event(Chardev *s, QEMUChrEvent event);
>>
>> +void qemu_chr_print_types(void);
>>  int qemu_chr_add_client(Chardev *s, int fd);
>>  Chardev *qemu_chr_find(const char *name);
>>
>> diff --git a/chardev/char.c b/chardev/char.c
>> index 78553125d3..028612c333 100644
>> --- a/chardev/char.c
>> +++ b/chardev/char.c
>> @@ -633,6 +633,16 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
>> Error **errp)
>>      return backend;
>>  }
>>
>> +void qemu_chr_print_types(void)
>> +{
>> +    GString *str =3D g_string_new("");
>>
>
> Suggest g_auto here

g_autoptr(GList) str =3D ..., I presume.

> +
>> +    chardev_name_foreach(help_string_append, str);
>> +
>> +    qemu_printf("Available chardev backend types: %s\n", str->str);
>> +    g_string_free(str, true);
>> +}
>> +
>>  Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
>>                                  Error **errp)
>>  {
>> @@ -644,12 +654,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
>> GMainContext *context,
>>      char *bid =3D NULL;
>>
>>      if (name && is_help_option(name)) {
>> -        GString *str =3D g_string_new("");
>> -
>> -        chardev_name_foreach(help_string_append, str);
>> -
>> -        qemu_printf("Available chardev backend types: %s\n", str->str);
>> -        g_string_free(str, true);
>> +        qemu_chr_print_types();
>>          return NULL;
>>      }
>>
>> --
>> 2.28.0
>>
>>
>>
> anyway
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>



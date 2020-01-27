Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5244FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13FA020716
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ittc87A+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FA020716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw4gW-0005a7-85
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 08:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iw4fl-00052i-Iu
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:43:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iw4fj-0007MF-DQ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:43:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35009
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iw4fj-0007JQ-A3
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580132602;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10DSYiJcSFGABgs3sLkkoI2zq2J3Y515cOnHQ9UBE4c=;
 b=ittc87A+9l/klspdcCXJjTBOE8fLBmbCWhFGFA/AzClD2j9xfriTA6h2meYbjImEaITAIy
 nXLQkGeWarQFl7FGENNxLhfIa5KxvR/ZNZMvfrWEqgnnMZQ7B22oPZ5ZO73F7PxZ0Njgxw
 aqTYabclUTw0Vvnb2/lhJaSKEvPrM40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-NrxJXq4kPyGHtWXd0w09NA-1; Mon, 27 Jan 2020 08:43:20 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51904107ACC4
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 13:43:19 +0000 (UTC)
Received: from redhat.com (ovpn-116-91.ams2.redhat.com [10.36.116.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA1B55890;
 Mon, 27 Jan 2020 13:43:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 19/21] migration: Add zlib compression multifd support
In-Reply-To: <20200124134418.GS2970@work-vm> (David Alan Gilbert's message of
 "Fri, 24 Jan 2020 13:44:18 +0000")
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-20-quintela@redhat.com>
 <20200124134418.GS2970@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Mon, 27 Jan 2020 14:43:16 +0100
Message-ID: <87h80h2ex7.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: NrxJXq4kPyGHtWXd0w09NA-1
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---

>> +    /* We will never have more than page_count pages */
>> +    z->zbuff_len =3D page_count * qemu_target_page_size();
>> +    z->zbuff_len *=3D 2;
>> +    z->zbuff =3D g_try_malloc(z->zbuff_len);
>> +    if (!z->zbuff) {
>
> Does a deflateEnd need to be called here?

Shouldnt matter, but I think that yes.

>
>> +        g_free(z);
>> +        error_setg(errp, "multifd %d: out of memory for zbuff", p->id);
>> +        return -1;
>> +    }
>> +    return 0;
>
> I'd like to understand more aobut the failure path - lets say we exit
> through one of those return -1's, p->data is still set to point to z
> which is now been free'd.  Will zlib_send_cleanup get called?
> Maybe it's safer to move the 'p->data =3D z' to right at the bottom befor=
e
> the return 0 ?

Just did that. Good catch.

>
>> +}
>> +
>> +/**
>> + * zlib_send_cleanup: cleanup send side
>> + *
>> + * Close the channel and return memory.
>> + *
>> + * @p: Params for the channel that we are using
>> + */
>> +static void zlib_send_cleanup(MultiFDSendParams *p, Error **errp)
>> +{
>> +    struct zlib_data *z =3D p->data;
>
> As previously asked above, could this ever get called if zlib_send_setup
> has failed? If so does this need to check for !z ?

No.
if multifd_zlib_setup() returns !=3D 0, then multifd_save_setup() returns
!=3D 0, and then we just signal an error and then we cancel migration in
multifd_fd_connect.

So, if z is NULL, we are already in big trouble.

>> +
>> +    for (i =3D 0; i < used; i++) {
>> +        uint32_t available =3D z->zbuff_len - out_size;
>> +        int flush =3D Z_NO_FLUSH;
>> +
>> +        if (i =3D=3D used  - 1) {
>
> Odd double space formatting there.

Ouch.  Changed.
>> +    /* We will never have more than page_count pages */
>> +    z->zbuff_len =3D page_count * qemu_target_page_size();
>> +    /* We know compression "could" use more space */
>> +    z->zbuff_len *=3D 2;
>> +    z->zbuff =3D g_try_malloc(z->zbuff_len);
>> +    if (!z->zbuff) {
>
> inflateEnd and similar question to save?

Done.

>> +    for (i =3D 0; i < used; i++) {
>> +        struct iovec *iov =3D &p->pages->iov[i];
>> +        int flush =3D Z_NO_FLUSH;
>> +
>> +        if (i =3D=3D used  - 1) {
>> +            flush =3D Z_SYNC_FLUSH;
>> +        }
>> +
>> +        zs->avail_out =3D iov->iov_len;
>> +        zs->next_out =3D iov->iov_base;
>> +
>> +        ret =3D inflate(zs, flush);
>> +        if (ret !=3D Z_OK) {
>> +            error_setg(errp, "multifd %d: inflate returned %d instead o=
f Z_OK",
>> +                       p->id, ret);
>> +            return ret;
>> +        }
>> +        out_size +=3D iov->iov_len;
>
> How do we know that's iov_len ?

Because we never had fails O:-)
(If it is not, we have a corrupted stream or something has gone very
wrong).

You win.  I think that the correct value is:

uint32_t out_size =3D zs->total_out;
...

out_size +=3D zs->total_out - out_size;

As a bonus, we can do that outside of the loop.

Thanks, Juan.



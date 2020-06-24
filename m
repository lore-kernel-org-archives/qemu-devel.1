Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47D1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 12:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B078120789
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 12:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0SYYc9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B078120789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo4eq-0007mD-03
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 08:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jo4dz-0006ml-9O
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 08:36:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39885
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jo4dw-00064L-Mu
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 08:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593002203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=opKH69XXLqj3svXHPJ0r/GS0MKyqsWbvihoL2eyGg2g=;
 b=a0SYYc9lOuUc3tz5JNkDz5/iDt+fzK0Yu2zqvPFo11Nfeh8ODQ1B3JlagsbqbmmMMVgAR/
 ncRfMVhm6xwr8ejIbbIzaFwhYKmt1StzpYqbMXyIEDxGmi9SDT7crdxBuCKTfQX5GfYTrU
 XyVALbvkyKoqae4vBPKB1yP40kbFVWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-4833efB-NxScAFMiiqgXVQ-1; Wed, 24 Jun 2020 08:36:41 -0400
X-MC-Unique: 4833efB-NxScAFMiiqgXVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21BA8804013;
 Wed, 24 Jun 2020 12:36:40 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-87.ams2.redhat.com [10.36.114.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71C6A6106A;
 Wed, 24 Jun 2020 12:36:36 +0000 (UTC)
Date: Wed, 24 Jun 2020 14:36:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/2] vvfat: Check that updated filenames are valid
Message-ID: <20200624123635.GB9253@linux.fritz.box>
References: <20200623175534.38286-1-kwolf@redhat.com>
 <20200623175534.38286-2-kwolf@redhat.com>
 <33941063-cfcc-002b-5fe8-d37050d8e532@redhat.com>
MIME-Version: 1.0
In-Reply-To: <33941063-cfcc-002b-5fe8-d37050d8e532@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
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
Cc: nhuck15@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 ppandit@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.06.2020 um 20:21 hat Eric Blake geschrieben:
> On 6/23/20 12:55 PM, Kevin Wolf wrote:
> > FAT allows only a restricted set of characters in file names, and for
> > some of the illegal characters, it's actually important that we catch
> > them: If filenames can contain '/', the guest can construct filenames
> > containing "../" and escape from the assigned vvfat directory. The same
> > problem could arise if ".." was ever accepted as a literal filename.
> > 
> > Fix this by adding a check that all filenames are valid in
> > check_directory_consistency().
> > 
> > Reported-by: Nathan Huckleberry <nhuck15@gmail.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/vvfat.c | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> > 
> > diff --git a/block/vvfat.c b/block/vvfat.c
> > index c65a98e3ee..2fab371258 100644
> > --- a/block/vvfat.c
> > +++ b/block/vvfat.c
> > @@ -520,6 +520,25 @@ static void set_begin_of_direntry(direntry_t* direntry, uint32_t begin)
> >       direntry->begin_hi = cpu_to_le16((begin >> 16) & 0xffff);
> >   }
> > +static bool valid_filename(const unsigned char *name)
> > +{
> > +    unsigned char c;
> > +    if (!strcmp((const char*)name, ".") || !strcmp((const char*)name, "..")) {
> > +        return false;
> > +    }
> > +    for (; (c = *name); name++) {
> > +        if (!((c >= '0' && c <= '9') ||
> > +              (c >= 'A' && c <= 'Z') ||
> > +              (c >= 'a' && c <= 'z') ||
> > +              c > 127 ||
> > +              strchr("$%'-_@~`!(){}^#&.+,;=[]", c) != 0))
> 
> s/0/NULL/

Ok, though this line is just copied from to_valid_short_char(). Maybe I
can sneak in a (strictly speaking unrelated) change to that function to
keep both consistent.

> Hmm - would it be any more efficient to use a single comparison of strcspn()
> vs. strlen(), where you merely spell out the bytes that are rejected?  Out
> of 256 byte values, NUL is implicitly rejected (since these are C strings),
> the 128 high-bit bytes are all valid, and you have permitted 62 alnum and 23
> other characters; that leaves merely 42 byte values to explicitly list in a
> reject string.  Of course, writing the string literal containing those 42
> invalid bytes is itself a bit of an exercise in reading the ASCII table:
> 
> "\x01\x02\x03\x04\x05\x06\x07"
> "\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
> "\x10\x11\x12\x13\x14\x15\x16\x17"
> "\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
> " \"*/:<>?\\|\x7f"

I think this would be really hard to read.

The above condition is a pretty straighforward implementation of what
the spec says (even the order of characters is the same).

Kevin



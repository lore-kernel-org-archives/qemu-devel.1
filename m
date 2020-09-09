Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093A8C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61AFE20732
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnD240+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AFE20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFueu-0007Y1-9E
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 03:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFueH-0006uK-Q5
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 03:36:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24706
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFueD-00070X-No
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 03:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599636964;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NaRs5OzDbBX7cYGs9VuIi+J+pqQfT34c9yMTeCL9G7w=;
 b=AnD240+YRngKkrCYnStwAiob3KrOUluhoaSfC4o5vkShs5SYKCrG2NZ8ve+voJVA98zdCL
 fn+LvUv2gx1kuP8NWmPPeVGj9PnMDtA/9TJTvY6+FFz/LMgGcQqV3cTLko+B0xz7xmn9wT
 q1juznGLujpBqk3Fw5Bc9Wry1mbC7NM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-_oAJF2RaPr6Vz8oqOOaMDw-1; Wed, 09 Sep 2020 03:35:47 -0400
X-MC-Unique: _oAJF2RaPr6Vz8oqOOaMDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CF8F80EFA4;
 Wed,  9 Sep 2020 07:35:46 +0000 (UTC)
Received: from redhat.com (ovpn-112-207.ams2.redhat.com [10.36.112.207])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4184860C0F;
 Wed,  9 Sep 2020 07:35:40 +0000 (UTC)
Date: Wed, 9 Sep 2020 08:35:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/5] hw/smbios: support loading OEM strings values from a
 file
Message-ID: <20200909073537.GB1011023@redhat.com>
References: <20200908165438.1008942-1-berrange@redhat.com>
 <20200908165438.1008942-2-berrange@redhat.com>
 <cd82e5fe-28d9-39c3-871d-1a538fc1e55b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cd82e5fe-28d9-39c3-871d-1a538fc1e55b@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 08, 2020 at 08:24:35PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Daniel,
> 
> On 9/8/20 6:54 PM, Daniel P. Berrangé wrote:
> > Some applications want to pass quite large values for the OEM strings
> > entries. Rather than having huge strings on the command line, it would
> > be better to load them from a file, as supported with -fw_cfg.
> > 
> > This introduces the "valuefile" parameter allowing for:
> > 
> >   $ echo -n "thisthing" > mydata.txt
> >   $ qemu-system-x86_64 \
> >     -smbios type=11,value=something \
> >     -smbios type=11,valuefile=mydata.txt \
> >     -smbios type=11,value=somemore \
> >     ...other args...
> > 
> > Now in the guest
> > 
> > $ dmidecide -t 11
> > Getting SMBIOS data from sysfs.
> > SMBIOS 2.8 present.
> > 
> > Handle 0x0E00, DMI type 11, 5 bytes
> > OEM Strings
> > 	String 1: something
> > 	String 2: thisthing
> > 	String 3: somemore
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  hw/smbios/smbios.c | 72 +++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 59 insertions(+), 13 deletions(-)
> > 
> > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > index 7cc950b41c..8450fad285 100644
> > --- a/hw/smbios/smbios.c
> > +++ b/hw/smbios/smbios.c
> > @@ -110,7 +110,7 @@ static struct {
> >  
> >  static struct {
> >      size_t nvalues;
> > -    const char **values;
> > +    char **values;
> >  } type11;
> >  
> >  static struct {
> > @@ -314,6 +314,11 @@ static const QemuOptDesc qemu_smbios_type11_opts[] = {
> >          .type = QEMU_OPT_STRING,
> >          .help = "OEM string data",
> >      },
> > +    {
> > +        .name = "path",
> > +        .type = QEMU_OPT_STRING,
> > +        .help = "OEM string data from file",
> > +    },
> >  };
> >  
> >  static const QemuOptDesc qemu_smbios_type17_opts[] = {
> > @@ -641,6 +646,8 @@ static void smbios_build_type_11_table(void)
> >  
> >      for (i = 0; i < type11.nvalues; i++) {
> >          SMBIOS_TABLE_SET_STR_LIST(11, type11.values[i]);
> > +        g_free(type11.values[i]);
> > +        type11.values[i] = NULL;
> >      }
> >  
> >      SMBIOS_BUILD_TABLE_POST;
> > @@ -940,9 +947,8 @@ static void save_opt(const char **dest, QemuOpts *opts, const char *name)
> >  
> >  
> >  struct opt_list {
> > -    const char *name;
> >      size_t *ndest;
> > -    const char ***dest;
> > +    char ***dest;
> >  };
> >  
> >  static int save_opt_one(void *opaque,
> > @@ -951,23 +957,61 @@ static int save_opt_one(void *opaque,
> >  {
> >      struct opt_list *opt = opaque;
> >  
> > -    if (!g_str_equal(name, opt->name)) {
> > -        return 0;
> > +    if (g_str_equal(name, "path")) {
> > +        g_autoptr(GByteArray) data = g_byte_array_new();
> > +        g_autofree char *buf = g_new(char, 4096);
> > +        ssize_t ret;
> > +        int fd = qemu_open(value, O_RDONLY);
> 
> While not use g_file_get_contents()?

qemu_open lets mgmt apps pass in pre-opened FDs using /dev/fdset/NN
syntax.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



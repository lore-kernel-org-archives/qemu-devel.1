Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDC0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA46820709
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yfiv1PVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA46820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxnjT-00020T-Uv
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxniI-000163-Rh
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:33:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23452
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxniG-00082G-VA
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595320404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F3HOz6ox4WfgXzS8uNt+aJRIXq6V4kbf7PA5S7YE9Rg=;
 b=Yfiv1PVWtkwdZJNGsUijdfQtJhtd2WLhqaYQ7VIA3kYOZtbWXyjbohLAwe16MdimjboHr+
 4TUPuLwbziea+zmR5KwFUQIdDIvK4/cZIeX7nkQUWpW2EybJM0Vz7rWJIFxcRnW9++LGBu
 S/dToCkPU+fpuKCtt0aMYlDv0waMejk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-CzUVAQmtPcCXAiTuxbxXpg-1; Tue, 21 Jul 2020 04:33:21 -0400
X-MC-Unique: CzUVAQmtPcCXAiTuxbxXpg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE05E1009629;
 Tue, 21 Jul 2020 08:33:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E5DB60BF4;
 Tue, 21 Jul 2020 08:33:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C65D111CA27; Tue, 21 Jul 2020 10:33:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH-for-5.1] hw/nvram/fw_cfg: Let fw_cfg_add_from_generator()
 return boolean value
References: <20200720123521.8135-1-philmd@redhat.com>
 <34e8619f-4301-d746-fe3f-c340040c22c1@redhat.com>
Date: Tue, 21 Jul 2020 10:33:16 +0200
In-Reply-To: <34e8619f-4301-d746-fe3f-c340040c22c1@redhat.com> (Laszlo Ersek's
 message of "Mon, 20 Jul 2020 23:57:42 +0200")
Message-ID: <87r1t59sj7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:46:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laszlo Ersek <lersek@redhat.com> writes:

> On 07/20/20 14:35, Philippe Mathieu-Daud=C3=A9 wrote:
>> Commits b6d7e9b66f..a43770df5d simplified the error propagation.
>> Similarly to commit 6fd5bef10b "qom: Make functions taking Error**
>> return bool, not void", let fw_cfg_add_from_generator() return a
>> boolean value, not void.
>> This allow to simplify parse_fw_cfg() and fixes the error handling
>> issue reported by Coverity (CID 1430396):
>>=20
>>   In parse_fw_cfg():
>>=20
>>     Variable assigned once to a constant guards dead code.
>>=20
>>     Local variable local_err is assigned only once, to a constant
>>     value, making it effectively constant throughout its scope.
>>     If this is not the intent, examine the logic to see if there
>>     is a missing assignment that would make local_err not remain
>>     constant.

It's the call of fw_cfg_add_from_generator():

        Error *local_err =3D NULL;

        fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
        if (local_err) {
            error_propagate(errp, local_err);
            return -1;
        }
        return 0;

If it fails, parse_fw_cfg() sets an error and returns 0, which is wrong.
Harmless, because the only caller passes &error_fatal.

Please work this impact assessment into the commit message.

>>=20
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Fixes: Coverity CID 1430396: 'Constant' variable guards dead code (DEADC=
ODE)
>> Fixes: 6552d87c48 ("softmmu/vl: Let -fw_cfg option take a 'gen_id' argum=
ent")
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  include/hw/nvram/fw_cfg.h |  4 +++-
>>  hw/nvram/fw_cfg.c         | 10 ++++++----
>>  softmmu/vl.c              |  6 +-----
>>  3 files changed, 10 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
>> index 11feae3177..d90857f092 100644
>> --- a/include/hw/nvram/fw_cfg.h
>> +++ b/include/hw/nvram/fw_cfg.h
>> @@ -302,8 +302,10 @@ void *fw_cfg_modify_file(FWCfgState *s, const char =
*filename, void *data,
>>   * will be used; also, a new entry will be added to the file directory
>>   * structure residing at key value FW_CFG_FILE_DIR, containing the item=
 name,
>>   * data size, and assigned selector key value.
>> + *
>> + * Returns: %true on success, %false on error.
>>   */
>> -void fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
>> +bool fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
>>                                 const char *gen_id, Error **errp);
>> =20
>>  FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 3b1811d3bf..c88aec4341 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -1032,7 +1032,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const char=
 *filename,
>>      return NULL;
>>  }
>> =20
>> -void fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
>> +bool fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
>>                                 const char *gen_id, Error **errp)
>>  {
>>      ERRP_GUARD();
>> @@ -1044,20 +1044,22 @@ void fw_cfg_add_from_generator(FWCfgState *s, co=
nst char *filename,
>>      obj =3D object_resolve_path_component(object_get_objects_root(), ge=
n_id);
>>      if (!obj) {
>>          error_setg(errp, "Cannot find object ID '%s'", gen_id);
>> -        return;
>> +        return false;
>>      }
>>      if (!object_dynamic_cast(obj, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)=
) {
>>          error_setg(errp, "Object ID '%s' is not a '%s' subclass",
>>                     gen_id, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE);
>> -        return;
>> +        return false;
>>      }
>>      klass =3D FW_CFG_DATA_GENERATOR_GET_CLASS(obj);
>>      array =3D klass->get_data(obj, errp);
>>      if (*errp) {
>> -        return;
>> +        return false;
>>      }
>>      size =3D array->len;
>>      fw_cfg_add_file(s, filename, g_byte_array_free(array, TRUE), size);
>> +
>> +    return true;
>>  }
>> =20
>>  static void fw_cfg_machine_reset(void *opaque)
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> index f476ef89ed..3416241557 100644
>> --- a/softmmu/vl.c
>> +++ b/softmmu/vl.c
>> @@ -2070,11 +2070,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *o=
pts, Error **errp)
>>          size =3D strlen(str); /* NUL terminator NOT included in fw_cfg =
blob */
>>          buf =3D g_memdup(str, size);
>>      } else if (nonempty_str(gen_id)) {
>> -        Error *local_err =3D NULL;
>> -
>> -        fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
>> -        if (local_err) {
>> -            error_propagate(errp, local_err);
>> +        if (!fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp)) {
>>              return -1;
>>          }
>>          return 0;

The minimally invasive fix would be this one-liner:

    diff --git a/softmmu/vl.c b/softmmu/vl.c
    index f476ef89ed..46718c1eea 100644
    --- a/softmmu/vl.c
    +++ b/softmmu/vl.c
    @@ -2072,7 +2072,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *o=
pts, Error **errp)
         } else if (nonempty_str(gen_id)) {
             Error *local_err =3D NULL;

    -        fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
    +        fw_cfg_add_from_generator(fw_cfg, name, gen_id, &local_err);
             if (local_err) {
                 error_propagate(errp, local_err);
                 return -1;

I like yours better.  We have a long tail of functions taking the
conventional Error **errp parameter to convert from returning void to
bool.

> The retvals seem OK, but I have no idea if this plays nicely with the
> new ERRP_GUARD (which I'm just noticing in fw_cfg_add_from_generator()).

Return values don't interfere with ERRP_GUARD().

Below the hood, ERRP_GUARD() replaces problematic values of @errp by a
pointer to a local variable that is automatically propagated to the
original value.  Why is that useful?  From error.h's big comment:

 * Without ERRP_GUARD(), use of the @errp parameter is restricted:
 * - It must not be dereferenced, because it may be null.
 * - It should not be passed to error_prepend() or
 *   error_append_hint(), because that doesn't work with &error_fatal.
 * ERRP_GUARD() lifts these restrictions.

fw_cfg_add_from_generator() dereferences @errp to check for failure of
klass->get_data().

If ->get_data() returns null on error and non-null on success, we could
simplify:

  diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
  index 3b1811d3bf..dfa1f2012a 100644
  --- a/hw/nvram/fw_cfg.c
  +++ b/hw/nvram/fw_cfg.c
  @@ -1035,7 +1035,6 @@ void *fw_cfg_modify_file(FWCfgState *s, const char =
*filename,
   void fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
                                  const char *gen_id, Error **errp)
   {
  -    ERRP_GUARD();
       FWCfgDataGeneratorClass *klass;
       GByteArray *array;
       Object *obj;
  @@ -1053,7 +1052,7 @@ void fw_cfg_add_from_generator(FWCfgState *s, const=
 char *filename,
       }
       klass =3D FW_CFG_DATA_GENERATOR_GET_CLASS(obj);
       array =3D klass->get_data(obj, errp);
  -    if (*errp) {
  +    if (!array) {
           return;
       }
       size =3D array->len;

Clearer now?

> FWIW
>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>
> Thanks
> Laszlo

Preferably with an improved commit message:
Reviewed-by: Markus Armbruster <armbru@redhat.com>



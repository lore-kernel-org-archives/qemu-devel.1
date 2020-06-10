Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA40C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76AA420760
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CX77NC2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76AA420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiu6b-0008UA-OR
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 02:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitno-0004mO-H2
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 02:01:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33863
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitnm-0000iD-Su
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 02:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591768889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ia+jvRh1EcqL1juwYoh5aQ//CUb4lfRirr977ZiPhWk=;
 b=CX77NC2wKO63qjupZa6BnT0LNWOMyuiwlpwTuBiM0rhbG5OMsr62y9O0PBGMYCUuvvFB3Z
 1CdPhsk4bW3QhA+HaXLBNzE2c5KBL2pwjTjDz3SRvKgGpCWeWno6JEh+Fby6MSui9f8LLo
 clrdYp703vQ7t/aiYQjR4/JgznMAJjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-cnMrL4BtNEu93IrFud8JPA-1; Wed, 10 Jun 2020 02:01:26 -0400
X-MC-Unique: cnMrL4BtNEu93IrFud8JPA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A134835B68;
 Wed, 10 Jun 2020 06:01:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF4AA8928C;
 Wed, 10 Jun 2020 06:01:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6F82211386A6; Wed, 10 Jun 2020 08:01:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 10/16] qdev: Improve netdev property override error a bit
References: <20200605145625.2920920-1-armbru@redhat.com>
 <20200605145625.2920920-11-armbru@redhat.com>
 <c405aa63-d4b6-741e-90e4-c7df80146d42@redhat.com>
Date: Wed, 10 Jun 2020 08:01:23 +0200
In-Reply-To: <c405aa63-d4b6-741e-90e4-c7df80146d42@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 8 Jun 2020 08:06:08
 +0200")
Message-ID: <87tuzjjw7g.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
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
Cc: kwolf@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 mreitz@redhat.com, pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 6/5/20 4:56 PM, Markus Armbruster wrote:
>> qdev_prop_set_netdev() fails when the property already has a non-null
>> value.  Seems to go back to commit 30c367ed44
>> "qdev-properties-system.c: Allow vlan or netdev for -device, not
>> both", v1.7.0.  Board code doesn't expect failure, and crashes:
>>=20
>>     $ qemu-system-x86_64 --nodefaults -nic user -netdev user,id=3Dnic0 -=
global e1000.netdev=3Dnic0
>>     Unexpected error in error_set_from_qdev_prop_error() at /work/armbru=
/qemu/hw/core/qdev-properties.c:1101:
>>     qemu-system-x86_64: Property 'e1000.netdev' doesn't take value '__or=
g.qemu.nic0
>>     '
>>     Aborted (core dumped)
>>=20
>> -device and device_add handle the failure:
>>=20
>>     $ qemu-system-x86_64 -nodefaults -netdev user,id=3Dnet0 -netdev user=
,id=3Dnet1 -device e1000,netdev=3Dnet0,netdev=3Dnet1
>>     qemu-system-x86_64: -device e1000,netdev=3Dnet0,netdev=3Dnet1: Prope=
rty 'e1000.netdev' doesn't take value 'net1'
>>     $ qemu-system-x86_64 -nodefaults -S -display none -monitor stdio -ne=
tdev user,id=3Dnet0 -netdev user,id=3Dnet1 -global e1000.netdev=3Dnet0
>>     QEMU 5.0.50 monitor - type 'help' for more information
>>     (qemu) qemu-system-x86_64: warning: netdev net0 has no peer
>>     qemu-system-x86_64: warning: netdev net1 has no peer
>>     device_add e1000,netdev=3Dnet1
>>     Error: Property 'e1000.netdev' doesn't take value 'net1'
>
> If patch accepted as it, might be worth Cc'ing qemu-stable@.

Not sure it's worthwhile.  It's just an error message, and nobody
complained so far.

>> Perhaps netdev property override could be made to work.  Perhaps it
>> should.  I'm not the right guy to figure this out.  What I can do is
>> improve the error message a bit:
>>=20
>>     (qemu) device_add e1000,netdev=3Dnet1
>>     Error: -global e1000.netdev=3D... conflicts with netdev=3Dnet1
>>=20
>> Cc: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/hw/qdev-properties.h     |  2 ++
>>  hw/core/qdev-properties-system.c | 30 +++++++++++++++++++++++++++---
>>  hw/core/qdev-properties.c        | 17 +++++++++++++++++
>>  3 files changed, 46 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
>> index f161604fb6..566419f379 100644
>> --- a/include/hw/qdev-properties.h
>> +++ b/include/hw/qdev-properties.h
>> @@ -248,6 +248,8 @@ void qdev_prop_set_macaddr(DeviceState *dev, const c=
har *name,
>>  void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
>> =20
>>  void qdev_prop_register_global(GlobalProperty *prop);
>> +const GlobalProperty *qdev_find_global_prop(DeviceState *dev,
>> +                                            const char *name);
>>  int qdev_prop_check_globals(void);
>>  void qdev_prop_set_globals(DeviceState *dev);
>>  void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState =
*dev,
>> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-=
system.c
>> index 9aa80495ee..20fd58e8f9 100644
>> --- a/hw/core/qdev-properties-system.c
>> +++ b/hw/core/qdev-properties-system.c
>> @@ -25,6 +25,28 @@
>>  #include "sysemu/iothread.h"
>>  #include "sysemu/tpm_backend.h"
>> =20
>> +static bool check_non_null(DeviceState *dev, const char *name,
>
> I see this is a static qdev function, but can we have a name that
> better match the content? Maybe qdev_global_prop_exists()?

Use of -global is one way to make it fail.  Another is duplicated key in
-device (but not device_add).  I believe no third way exists.  The
function sets a specific error when it finds -global, else a vague
error.

check_prop_still_unset()?

>> +                           const void *old_val, const char *new_val,
>> +                           Error **errp)
>> +{
>> +    const GlobalProperty *prop =3D qdev_find_global_prop(dev, name);
>> +
>> +    if (!old_val) {
>> +        return true;
>> +    }
>> +
>> +    if (prop) {
>> +        error_setg(errp, "-global %s.%s=3D... conflicts with %s=3D%s",
>> +                   prop->driver, prop->property, name, new_val);
>> +    } else {
>> +        /* Error message is vague, but a better one would be hard */
>> +        error_setg(errp, "%s=3D%s conflicts, and override is not implem=
ented",
>> +                   name, new_val);
>> +    }
>> +    return false;
>> +}
>> +
>> +
>>  /* --- drive --- */
>> =20
>>  static void get_drive(Object *obj, Visitor *v, const char *name, void *=
opaque,
>> @@ -299,14 +321,16 @@ static void set_netdev(Object *obj, Visitor *v, co=
nst char *name,
>>      }
>> =20
>>      for (i =3D 0; i < queues; i++) {
>> -
>>          if (peers[i]->peer) {
>>              err =3D -EEXIST;
>>              goto out;
>>          }
>> =20
>> -        if (ncs[i]) {
>> -            err =3D -EINVAL;
>> +        /*
>> +         * TODO Should this really be an error?  If no, the old value
>> +         * needs to be released before we store the new one.
>> +         */
>> +        if (!check_non_null(dev, name, ncs[i], str, errp)) {
>>              goto out;
>>          }
>> =20
>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> index cc924815da..8c8beb56b2 100644
>> --- a/hw/core/qdev-properties.c
>> +++ b/hw/core/qdev-properties.c
>> @@ -1181,6 +1181,23 @@ void qdev_prop_register_global(GlobalProperty *pr=
op)
>>      g_ptr_array_add(global_props(), prop);
>>  }
>> =20
>> +const GlobalProperty *qdev_find_global_prop(DeviceState *dev,
>> +                                            const char *name)
>
> Do you mind splitting this patch in 2? Adding qdev_find_global_prop
> first, then using it to avoid the crash.

>
>> +{
>> +    GPtrArray *props =3D global_props();
>> +    const GlobalProperty *p;
>> +    int i;
>> +
>> +    for (i =3D 0; i < props->len; i++) {
>> +        p =3D g_ptr_array_index(props, i);
>> +        if (object_dynamic_cast(OBJECT(dev), p->driver)
>> +            && !strcmp(p->property, name)) {
>
> Laszlo pointed out elsewhere this doesn't match our CODING_STYLE.rst:
>
> Multiline Indent
> ----------------
  [...]
  In case of if/else, while/for, align the secondary lines just after the
  opening parenthesis of the first.

> For example:
>
> .. code-block:: c
>
>     if (a =3D=3D 1 &&
>         b =3D=3D 2) {
>
>     while (a =3D=3D 1 &&
>            b =3D=3D 2) {

This is about how much to indent, not where to break the line.

Existing practice is inconsistent.

> I prefer the style you used, it looks safer. Eric once explained why
> it is safer but I can't find his rationals anymore. I'll keep
> searching to suggest a CODING_STYLE update.

For what it's worth, Python's PEP 8:

    Should a Line Break Before or After a Binary Operator?

    For decades the recommended style was to break after binary
    operators.  But this can hurt readability in two ways: the operators
    tend to get scattered across different columns on the screen, and
    each operator is moved away from its operand and onto the previous
    line.  Here, the eye has to do extra work to tell which items are
    added and which are subtracted:

    # Wrong:
    # operators sit far away from their operands
    income =3D (gross_wages +
              taxable_interest +
              (dividends - qualified_dividends) -
              ira_deduction -
              student_loan_interest)

    To solve this readability problem, mathematicians and their
    publishers follow the opposite convention.  Donald Knuth explains
    the traditional rule in his Computers and Typesetting series:
    "Although formulas within a paragraph always break after binary
    operations and relations, displayed formulas always break before
    binary operations" [3].

    Following the tradition from mathematics usually results in more
    readable code:

    # Correct:
    # easy to match operators with operands
    income =3D (gross_wages
              + taxable_interest
              + (dividends - qualified_dividends)
              - ira_deduction
              - student_loan_interest)

    In Python code, it is permissible to break before or after a binary
    operator, as long as the convention is consistent locally.  For new
    code Knuth's style is suggested.

https://www.python.org/dev/peps/pep-0008/#should-a-line-break-before-or-aft=
er-a-binary-operator

>> +            return p;
>> +        }
>> +    }
>> +    return NULL;
>> +}
>> +
>>  int qdev_prop_check_globals(void)
>>  {
>>      int i, ret =3D 0;
>>=20



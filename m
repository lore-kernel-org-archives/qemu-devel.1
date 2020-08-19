Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F027C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 05:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E1E2078B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 05:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="Jpt7lsc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E1E2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8GVM-0001m4-6m
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 01:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1k8GUq-0001Lj-7Q
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:18:48 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:60308)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1k8GUn-0003eE-T1
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:18:47 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id CA05E405D5;
 Wed, 19 Aug 2020 15:18:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1597814323;
 bh=mItHlOsl6UKOt5Q2J9goqHkAExhKgMpbZHfc6/doIcM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Jpt7lsc5XcmTyZmuVsO07XuzxVWMBoKDoUjuxYvbOeKfbqnU7yqCmQfGGcBc0sa/P
 6oEk6qkmhB88FPIz1NnxpNoMhNrd+xAcqHsIgA3V2tFb6iMAiQCWCgt7ZjfwqAnc4R
 C0toIotzt3YOvFxBvGCWGyosTKpUgODmHPfe2urE=
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
 by www1.hostfission.com (Postfix) with ESMTP id BA1789D947;
 Wed, 19 Aug 2020 15:18:43 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Wed, 19 Aug 2020 15:18:43 +1000
From: Geoffrey McRae <geoff@hostfission.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Subject: Re: [PATCH v3 1/1] audio/jack: fix use after free segfault
In-Reply-To: <36f399e3-028e-9187-fc90-288a6ad7f64c@redhat.com>
References: <20200819011835.92737-1-geoff@hostfission.com>
 <20200819011835.92737-2-geoff@hostfission.com>
 <34c4c83a-c870-0d21-1a15-3da76b4e5488@redhat.com>
 <5c2a509c0807efbc1fab24f54fad150c@hostfission.com>
 <36f399e3-028e-9187-fc90-288a6ad7f64c@redhat.com>
Message-ID: <48b79becba651bbf1150d0c6ae7f94ec@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.3.8
Received-SPF: pass client-ip=139.99.139.48; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:36:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020-08-19 14:46, Philippe Mathieu-Daudé wrote:
> On 8/19/20 5:36 AM, Geoffrey McRae wrote:
>> 
>> 
>> On 2020-08-19 13:32, Philippe Mathieu-Daudé wrote:
>>> Hi Geoffrey,
>>> 
>>> On 8/19/20 3:18 AM, Geoffrey McRae wrote:
>>>> The client may have been freed already by a secondary audio device
>>>> recovering its session as JACK2 has some cleanup code to work around
>>>> broken clients, which doesn't account for well behaved clients.
>>>> 
>>>> https://github.com/jackaudio/jack2/issues/627
>>>> 
>>>> As JACK1 and JACK2 are interchangeable and JACK2 has "cleanup" 
>>>> routine
>>>> that JACK1 does not have, we need to determine which version is in 
>>>> use
>>>> at runtime. Unfortunatly there is no way to determine which is in 
>>>> use
>>>> other then to look for symbols that are missing in JACK1, which in 
>>>> this
>>>> case is `jack_get_version`.
>>>> 
>>>> An issue has been raised over this, but to be compatible with older
>>>> versions we must use this method to determine which library is in 
>>>> use.
>>>> If at some time the jack developers implement `jack_get_version` in
>>>> JACK1, this code will need to be revisited.
>>>> 
>>>> At worst the workaround will be enabled and this will introduce a 
>>>> small
>>>> memory leak if the jack server is restarted. This however is better 
>>>> then
>>>> the alternative which would be a use after free segfault.
>>>> 
>>>> Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
>>>> ---
>>>>  audio/jackaudio.c | 37 ++++++++++++++++++++++++++++++++++++-
>>>>  configure         |  4 +++-
>>>>  2 files changed, 39 insertions(+), 2 deletions(-)
>>>> 
>>>> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
>>>> index 72ed7c4929..d1685999c3 100644
>>>> --- a/audio/jackaudio.c
>>>> +++ b/audio/jackaudio.c
>>>> @@ -31,6 +31,7 @@
>>>>  #define AUDIO_CAP "jack"
>>>>  #include "audio_int.h"
>>>> 
>>>> +#include <dlfcn.h>
>>>>  #include <jack/jack.h>
>>>>  #include <jack/thread.h>
>>>> 
>>>> @@ -84,6 +85,7 @@ typedef struct QJackIn {
>>>>  }
>>>>  QJackIn;
>>>> 
>>>> +static int QJackWorkaroundCloseBug;
>>>>  static int qjack_client_init(QJackClient *c);
>>>>  static void qjack_client_connect_ports(QJackClient *c);
>>>>  static void qjack_client_fini(QJackClient *c);
>>>> @@ -563,7 +565,10 @@ static void qjack_client_fini(QJackClient *c)
>>>>          /* fallthrough */
>>>> 
>>>>      case QJACK_STATE_SHUTDOWN:
>>>> -        jack_client_close(c->client);
>>>> +        if (!QJackWorkaroundCloseBug) {
>>>> +            jack_client_close(c->client);
>>>> +        }
>>>> +        c->client = NULL;
>>>>          /* fallthrough */
>>>> 
>>>>      case QJACK_STATE_DISCONNECTED:
>>>> @@ -662,6 +667,36 @@ static void qjack_info(const char *msg)
>>>> 
>>>>  static void register_audio_jack(void)
>>>>  {
>>>> +    void *handle;
>>>> +
>>>> +    /*
>>>> +     * As JACK1 and JACK2 are interchangeable and JACK2 has
>>>> "cleanup" routine
>>>> +     * that JACK1 does not have, we need to determine which version
>>>> is in use at
>>>> +     * runtime. Unfortunatly there is no way to determine which is
>>>> in use other
>>>> +     * then to look for symbols that are missing in JACK1, which in
>>>> this case is
>>>> +     * `jack_get_version`. An issue has been raised over this, but
>>>> to be
>>>> +     * compatible with older versions we must use this method to
>>>> determine which
>>>> +     * library is in use. If at some time the jack developers 
>>>> implement
>>>> +     * `jack_get_version` in JACK1, this code will need to be
>>>> revisited.
>>>> +     *
>>>> +     * At worst the workaround will be enabled and we will 
>>>> introduce
>>>> a small
>>>> +     * memory leak if the jack server is restarted. This is better
>>>> then the
>>>> +     * alternative which would be a use after free segfault.
>>>> +     */
>>>> +
>>>> +    handle = dlopen("libjack.so", RTLD_LAZY | RTLD_NOLOAD);
>>>> +    if (!handle) {
>>>> +        dolog("unable to open libjack.so to determine version\n");
>>>> +        dolog("assuming JACK2 and enabling the close bug
>>>> workaround\n");
>>>> +        QJackWorkaroundCloseBug = 1;
>>>> +    } else {
>>>> +        if (dlsym(handle, "jack_get_version")) {
>>>> +            dolog("JACK2 detected, enabling close bug 
>>>> workaround\n");
>>>> +            QJackWorkaroundCloseBug = 1;
>>>> +        }
>>>> +        dlclose(handle);
>>>> +    }
>>>> +
>>>>      audio_driver_register(&jack_driver);
>>>>      jack_set_thread_creator(qjack_thread_creator);
>>>>      jack_set_error_function(qjack_error);
>>>> diff --git a/configure b/configure
>>>> index 2acc4d1465..43d2893fbb 100755
>>>> --- a/configure
>>>> +++ b/configure
>>>> @@ -3754,7 +3754,8 @@ for drv in $audio_drv_list; do
>>>> 
>>>>      jack | try-jack)
>>>>      if $pkg_config jack --exists; then
>>>> -        jack_libs=$($pkg_config jack --libs)
>>>> +        # dl is needed to check at runtime if jack1 or jack2 is in 
>>>> use
>>>> +        jack_libs="$($pkg_config jack --libs) -ldl"
>>>>          if test "$drv" = "try-jack"; then
>>>>              audio_drv_list=$(echo "$audio_drv_list" | sed -e
>>>> 's/try-jack/jack/')
>>>>          fi
>>> 
>>> Why not checking jack_get_version() using compile_prog here?
>>> 
>>> Thanks,
>>> 
>>> Phil.
>> 
>> Hi Phil,
>> 
>> Because the library can be swapped out after compile time as the
>> versions are ABI compatible by design.
> 
> IIUC in the GH issue you linked you describe a problem from v1.9.1
> to v1.9.14. I see jack_get_version() is already available in v1.9.1:
> https://github.com/jackaudio/jack2/blob/1.9.1/common/jack/jack.h#L55

Do not confuse 1.9.1 with JACK1, this project has very strange 
versioning.

JACK1 uses the headers located here.
https://github.com/jackaudio/headers/blob/master/jack.h

> 
> Why would someone link with jack2 then replace it with jack1 without
> rebuilding? That sounds silly...

Distributions commonly let you select which jack library you wish to run 
with and allow them to be swapped around.

> 
>> 
>> -Geoff
>> 


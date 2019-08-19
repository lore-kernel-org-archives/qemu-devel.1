Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3D7C3A5A2
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B44206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjsspxvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B44206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hziLY-0002vY-EW
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 10:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1hziKm-0002PA-JZ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hziKl-0004kw-8O
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:08:32 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:34912)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hziKk-0004jP-UO
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:08:31 -0400
Received: by mail-ed1-x542.google.com with SMTP id w20so1796446edd.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 07:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=y0vb0zDDucek2X2Zwz2Pk5/sXeMUw49VlVvAK71uEUc=;
 b=bjsspxvSp+lYkpvzuULC8xEDozv4XlzoWq5z34fgqWt3gXEu8OMk6chx5ROLGzStxg
 kmFnLa2r0VOgPLNkj0Q2TylYsPB6iwfktP3t5ocq0Y/NDRLmhKnJxTZCfK9sogUEemWe
 ZBXnn4h8GLVqCn6NcYCGPUAcloVMUxgQ7nKXS0W8fY5mbF46KgI2b1LXCO3a9lkuI/8H
 5uZ/TNX80aDllQlZ2YS5W2NnYxdqBhKDS0oi5bxXLduEvREtdmQNATsz4EcsRW2uRJdI
 cE4IVidyFyczlSlrZss0bRtYCzX6hKWJ/Jk/wT29vyootV6/eQk64M/2Io2SCfv5D0JK
 vs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=y0vb0zDDucek2X2Zwz2Pk5/sXeMUw49VlVvAK71uEUc=;
 b=qNQ9BCgd9iTe5S8D5vWhStRC56PDfDnjACSi91YuccRq517Cyu55XCz2iUQK3gmNoX
 zrA3luBTuofbPKVjQ5nazXynKnPLfIeAXgQpiqisycMvQuuBbhhkLPe7SU+uNbilNFLi
 aE3Y8MwuvoIjz8imgoKFMuNqlEzQCTSFXA2X1y2wPg53EB+IEibb2ELC2sDzATuQSlwY
 De9xLD8v9ETZT6MnZ/zRcaeFFoTCC6ICmVKYheCGAZLukkXv3L3h5ubqRoAlsFMx91To
 lhSvIGuRR8a4MtvZoTgH5g2DPft7a7k9ulml37tN5oSYvxaHzFEDCc/1mflReRCrZJPi
 LNZg==
X-Gm-Message-State: APjAAAUDbb/V3q1bRBHrSLDZSk0bUP5YUE25ebYjXopx+BQqUFetiEgz
 7cApD6aovuIMcJWnppgWR5E=
X-Google-Smtp-Source: APXvYqwMTg3XdbD0XWi8kUtY+r7uhcXUG3C2Ziq5/i+0cAvd1yyvEr7DIav6qGVA4gsRlr2iWWWVUg==
X-Received: by 2002:aa7:d94d:: with SMTP id l13mr24782634eds.72.1566223709868; 
 Mon, 19 Aug 2019 07:08:29 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id j12sm2698313edt.66.2019.08.19.07.08.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 19 Aug 2019 07:08:29 -0700 (PDT)
Date: Mon, 19 Aug 2019 14:08:28 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190819140828.otv7vq5lahvquczl@master>
References: <20190621142739.23703-1-richardw.yang@linux.intel.com>
 <20190819112632.GA2765@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819112632.GA2765@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH] migrtion: define
 MigrationState/MigrationIncomingState.state as MigrationStatus
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 19, 2019 at 12:26:32PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> No functional change. Add default case to fix warning.
>
>I think the problem with this is that migrate_set_state uses an
>atomic_cmpxchg and so we have to be careful that the type we use
>is compatible with that.
>MigrationStatus is an enum and I think compilers are allowed to
>choose the types of that;  so I'm not sure we're guaranteed
>that an enum is always OK for the atomic_cmpxchg, and if it is

Took a look into the definition of atomic_cmpxchg, which finally calls

  * __atomic_compare_exchange_n for c++11
  * __sync_val_compare_and_swap

Both of them take two pointers to compare and exchange its content.

Per C99 standard, http://www.open-std.org/JTC1/SC22/WG14/www/docs/n1256.pdf,
it mentioned:

  Each enumerated type shall be compatible with char, a signed integer type,
  or an unsigned integer type. The choice of type is implementation-defined,
  but shall be capable of representing the values of all the members of the
  enumeration.

Based on this, I think atomic_cmpxchg should work fine with enum.

>then we also might have to make the old_state and new_state
>variables match.
>

You are right.
>Dave
>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  migration/migration.c | 8 +++++++-
>>  migration/migration.h | 6 +++---
>>  2 files changed, 10 insertions(+), 4 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 2865ae3fa9..0fd2364961 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -946,6 +946,8 @@ static void fill_source_migration_info(MigrationInfo *info)
>>      case MIGRATION_STATUS_CANCELLED:
>>          info->has_status = true;
>>          break;
>> +    default:
>> +        return;
>>      }
>>      info->status = s->state;
>>  }
>> @@ -1054,6 +1056,8 @@ static void fill_destination_migration_info(MigrationInfo *info)
>>          info->has_status = true;
>>          fill_destination_postcopy_migration_info(info);
>>          break;
>> +    default:
>> +        return;
>>      }
>>      info->status = mis->state;
>>  }
>> @@ -1446,7 +1450,7 @@ void qmp_migrate_start_postcopy(Error **errp)
>>  
>>  /* shared migration helpers */
>>  
>> -void migrate_set_state(int *state, int old_state, int new_state)
>> +void migrate_set_state(MigrationStatus *state, int old_state, int new_state)
>>  {
>>      assert(new_state < MIGRATION_STATUS__MAX);
>>      if (atomic_cmpxchg(state, old_state, new_state) == old_state) {
>> @@ -1683,6 +1687,8 @@ bool migration_is_idle(void)
>>          return false;
>>      case MIGRATION_STATUS__MAX:
>>          g_assert_not_reached();
>> +    default:
>> +        g_assert_not_reached();
>>      }
>>  
>>      return false;
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 5e8f09c6db..418ee00053 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -65,7 +65,7 @@ struct MigrationIncomingState {
>>  
>>      QEMUBH *bh;
>>  
>> -    int state;
>> +    MigrationStatus state;
>>  
>>      bool have_colo_incoming_thread;
>>      QemuThread colo_incoming_thread;
>> @@ -151,7 +151,7 @@ struct MigrationState
>>      /* params from 'migrate-set-parameters' */
>>      MigrationParameters parameters;
>>  
>> -    int state;
>> +    MigrationStatus state;
>>  
>>      /* State related to return path */
>>      struct {
>> @@ -234,7 +234,7 @@ struct MigrationState
>>      bool decompress_error_check;
>>  };
>>  
>> -void migrate_set_state(int *state, int old_state, int new_state);
>> +void migrate_set_state(MigrationStatus *state, int old_state, int new_state);
>>  
>>  void migration_fd_process_incoming(QEMUFile *f);
>>  void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>> -- 
>> 2.19.1
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me


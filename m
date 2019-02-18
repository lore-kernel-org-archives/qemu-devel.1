Received: from eggs.gnu.org ([209.51.188.92]:48165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gveGL-0006Bd-Tw
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 03:26:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gveGL-0003Fx-A7
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 03:26:53 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gveGL-0003FY-3c
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 03:26:53 -0500
Received: by mail-pf1-x444.google.com with SMTP id n22so8185926pfa.3
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 00:26:52 -0800 (PST)
References: <20190111063732.10484-1-xiaoguangrong@tencent.com>
	<20190111063732.10484-3-xiaoguangrong@tencent.com>
	<20190115075154.GI24343@xz-x1> <20190115102404.GA2135@work-vm>
	<2caebc3a-ccd0-d8c6-0368-4f339f326cdf@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <fffceceb-b694-640a-a364-ec8439452fe3@gmail.com>
Date: Mon, 18 Feb 2019 16:26:45 +0800
MIME-Version: 1.0
In-Reply-To: <2caebc3a-ccd0-d8c6-0368-4f339f326cdf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] migration: fix memory leak when
 updating tls-creds and tls-hostname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, wei.w.wang@intel.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>, Markus Armbruster <armbru@redhat.com>



On 1/16/19 12:03 AM, Eric Blake wrote:
> On 1/15/19 4:24 AM, Dr. David Alan Gilbert wrote:
> 
>> I think the problem is that
>> migrate_params_check checks a MigrationParameters
>>
>> while the QMP command gives us a MigrateSetParameters; but we also use
>> migrate_params_check for the global check you added (8b0b29dc) which is
>> against migrationParameters; so that's why migrate_params_check takes
>> a MigrationParameters.
>>
>> It's horrible we've got stuff duped so much.
> 
> Indeed.
> 
>>
>> However, I don't like this fix because if someone later was to add
>> a test for tls parameters to migrate_params_check, then they would be
>> confused why the hostname/creds weren't checked.
>> So while we have migrate_params_test_apply, it should cover all
>> parameters.
>>
>> I think a cleaner check would be to write a MigrateParameters_free
>> that free'd any strings, and call that in qmp_migrate_set_parameters
>> on both exit paths.
> 
> We already have it; it's named qapi_free_MigrationParameters(),
> generated in qapi-types-migration.h.
> 

Thank you all (and sorry for the delay reply due to Chinese New Year :)),
i will use this interface instead in the next version.

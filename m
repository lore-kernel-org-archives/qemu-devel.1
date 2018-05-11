Received: from eggs.gnu.org ([2001:4830:134:3::10]:47937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fHA6C-0001nK-4z
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fHA67-0005E5-HV
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:36:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45338 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fHA67-0005Dt-Co
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:36:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C868E402335F
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 15:36:42 +0000 (UTC)
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
	<1525423069-61903-8-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fb2fff97-38d2-d2f2-9696-c3d231ee9714@redhat.com>
Date: Fri, 11 May 2018 10:36:41 -0500
MIME-Version: 1.0
In-Reply-To: <1525423069-61903-8-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 07/11] cli: add --preconfig option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com

On 05/04/2018 03:37 AM, Igor Mammedov wrote:
> This option allows pausing QEMU in the new RUN_STATE_PRECONFIG state,
> allowing the configuration of QEMU from QMP before the machine jumps
> into board initialization code of machine_run_board_init()
> 
> The intent is to allow management to query machine state and additionally
> configure it using previous query results within one QEMU instance
> (i.e. eliminate the need to start QEMU twice, 1st to query board specific
> parameters and 2nd for actual VM start using query results for
> additional parameters).
> 
> The new option complements -S option and could be used with or without
> it. The difference is that -S pauses QEMU when the machine is completely
> initialized with all devices wired up and ready to execute guest code
> (QEMU needs only to unpause VCPUs to let guest execute its code),
> while the "preconfig" option pauses QEMU early before board specific init
> callback (machine_run_board_init) is executed and allows the configuration
> of machine parameters which will be used by board init code.
> 
> When early introspection/configuration is done, command 'exit-preconfig'
> should be used to exit RUN_STATE_PRECONFIG and transition to the next
> requested state (i.e. if -S is used then QEMU will pause the second
> time when board/device initialization is completed or start guest
> execution if -S isn't provided on CLI)
> 
> PS:
> Initially 'preconfig' is planned to be used for configuring numa
> topology depending on board specified possible cpus layout.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

> +This paused state is typically used by users to query machine state and/or
> +additionally configure the machine (by hotplugging devices) in runtime before
> +allowing VM code to run.
> +
> +However, at the -S pause point, it's impossible to configure options that affect
> +initial VM creation (like: -smp/-m/-numa ...) or cold plug devices. That's
> +when --preconfig command line option should be used. It allows pausing QEMU

s/when/when the/

> +before the initial VM creation, in a new preconfig state, where additional
> +queries and configuration can be performed via QMP before moving on to
> +the resulting configuration startup. In the preconfig state, QEMU only allows
> +a limited set of commands over the QMP monitor, where the commands do not
> +depend on an initialized machine, including but not limited to:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

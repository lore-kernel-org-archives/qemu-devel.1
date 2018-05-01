Received: from eggs.gnu.org ([2001:4830:134:3::10]:60180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDWsV-0006eh-BF
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDWsS-0006Kt-1m
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:07:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52700 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fDWsR-0006Ke-Sp
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:07:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F246406C740
	for <qemu-devel@nongnu.org>; Tue,  1 May 2018 15:07:31 +0000 (UTC)
Date: Tue, 1 May 2018 16:07:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180501150723.GF32129@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
	<1524841523-95513-4-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1524841523-95513-4-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 03/11] cli: add --preconfig option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, ehabkost@redhat.com, armbru@redhat.com

On Fri, Apr 27, 2018 at 05:05:15PM +0200, Igor Mammedov wrote:
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

> When early introspection/configuration is done, command 'exit-preconfig'
> should be used to exit RUN_STATE_PRECONFIG and transition to the next
> requested state (i.e. if -S is used then QEMU will pause the second
> time when board/device initialization is completed or start guest
> execution if -S isn't provided on CLI)

If we're going to introduce this --preconfig facility I would very much
like us to ensure that we do *not* need to continue to also use -S. IOW
it would be nice to essentially consider --preconfig a better impl of
-S and stop using -S, perhaps even deprecating it for removal.

What logical things does QEMU do after exiting pre-config stage, but
before starting CPUs that might be dependency for mgmt apps that would
neccessitate using both --preconfig and -S ?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

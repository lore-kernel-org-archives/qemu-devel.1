Received: from eggs.gnu.org ([209.51.188.92]:56477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gjeBG-0005ef-1O
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gjeBF-00025a-35
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:56:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gjeBE-00022G-Ol
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:56:00 -0500
Date: Wed, 16 Jan 2019 13:55:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190116055549.GB29461@xz-x1>
References: <20190111063732.10484-1-xiaoguangrong@tencent.com>
	<20190111063732.10484-3-xiaoguangrong@tencent.com>
	<20190115075154.GI24343@xz-x1> <20190115102404.GA2135@work-vm>
	<2caebc3a-ccd0-d8c6-0368-4f339f326cdf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2caebc3a-ccd0-d8c6-0368-4f339f326cdf@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, guangrong.xiao@gmail.com, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, wei.w.wang@intel.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Jan 15, 2019 at 10:03:53AM -0600, Eric Blake wrote:
> On 1/15/19 4:24 AM, Dr. David Alan Gilbert wrote:
> 
> > I think the problem is that
> > migrate_params_check checks a MigrationParameters
> > 
> > while the QMP command gives us a MigrateSetParameters; but we also use
> > migrate_params_check for the global check you added (8b0b29dc) which is
> > against migrationParameters; so that's why migrate_params_check takes
> > a MigrationParameters.
> > 
> > It's horrible we've got stuff duped so much.
> 
> Indeed.
> 
> > 
> > However, I don't like this fix because if someone later was to add
> > a test for tls parameters to migrate_params_check, then they would be
> > confused why the hostname/creds weren't checked.
> > So while we have migrate_params_test_apply, it should cover all
> > parameters.
> > 
> > I think a cleaner check would be to write a MigrateParameters_free
> > that free'd any strings, and call that in qmp_migrate_set_parameters
> > on both exit paths.
> 
> We already have it; it's named qapi_free_MigrationParameters(),
> generated in qapi-types-migration.h.

Yes this seems better.  Then IIUC patch 3 can be simplified as well
with it.

I'm doing one step back and reading below thread for more context that
I've missed:

  https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04526.html

Do we have chance/plan to remove these duplication for QEMU 4.0?

Thanks,

> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 




Regards,

-- 
Peter Xu

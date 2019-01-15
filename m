Received: from eggs.gnu.org ([209.51.188.92]:46535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gjLtP-0000YB-DQ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:24:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gjLtH-0002gA-ME
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:24:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gjLtH-0002fQ-Cs
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:24:15 -0500
Date: Tue, 15 Jan 2019 10:24:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190115102404.GA2135@work-vm>
References: <20190111063732.10484-1-xiaoguangrong@tencent.com>
	<20190111063732.10484-3-xiaoguangrong@tencent.com>
	<20190115075154.GI24343@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115075154.GI24343@xz-x1>
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
To: Peter Xu <peterx@redhat.com>
Cc: guangrong.xiao@gmail.com, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, wei.w.wang@intel.com, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>, Markus Armbruster <armbru@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> On Fri, Jan 11, 2019 at 02:37:31PM +0800, guangrong.xiao@gmail.com wrote:
> > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > 
> > If we update parameter, tls-creds and tls-hostname, these string
> > values are duplicated to local variables in migrate_params_test_apply()
> > by using g_strdup(), however these new allocated memory are missed to
> > be freed
> > 
> > Actually, they are not used to check anything, we can directly skip
> > them
> > 
> > Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> > ---
> >  migration/migration.c | 10 ----------
> >  1 file changed, 10 deletions(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index a82d594f29..fb39d7bec1 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1145,16 +1145,6 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
> >          dest->cpu_throttle_increment = params->cpu_throttle_increment;
> >      }
> >  
> > -    if (params->has_tls_creds) {
> > -        assert(params->tls_creds->type == QTYPE_QSTRING);
> > -        dest->tls_creds = g_strdup(params->tls_creds->u.s);
> > -    }
> > -
> > -    if (params->has_tls_hostname) {
> > -        assert(params->tls_hostname->type == QTYPE_QSTRING);
> > -        dest->tls_hostname = g_strdup(params->tls_hostname->u.s);
> > -    }
> > -
> 
> Hi, Guangrong,
> 
> The memleak seems to be correct here but before that I'm even a bit
> confused on why we need to copy the whole parameter list here instead
> of checking against a MigrateSetParameters* in migrate_params_check().
> Could anyone shed some light?  CC Markus too.

I think the problem is that
migrate_params_check checks a MigrationParameters

while the QMP command gives us a MigrateSetParameters; but we also use
migrate_params_check for the global check you added (8b0b29dc) which is
against migrationParameters; so that's why migrate_params_check takes
a MigrationParameters.

It's horrible we've got stuff duped so much.

However, I don't like this fix because if someone later was to add
a test for tls parameters to migrate_params_check, then they would be
confused why the hostname/creds weren't checked.
So while we have migrate_params_test_apply, it should cover all
parameters.

I think a cleaner check would be to write a MigrateParameters_free
that free'd any strings, and call that in qmp_migrate_set_parameters
on both exit paths.

Dave

> Thanks,
> 
> >      if (params->has_max_bandwidth) {
> >          dest->max_bandwidth = params->max_bandwidth;
> >      }
> > -- 
> > 2.14.5
> > 
> 
> Regards,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dn0qn-0007ob-06
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dn0qj-0006UF-2e
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:08:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dn0qi-0006Tx-Rk
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:07:56 -0400
Date: Wed, 30 Aug 2017 12:07:43 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170830110743.GF18526@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170823083901.852-1-quintela@redhat.com>
	<20170823083901.852-3-quintela@redhat.com>
	<20170823115327.GC2648@work-vm>
	<bbe64c5c-8906-2bf9-92a8-8fda49100505@kaod.org>
	<874lsp72hg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874lsp72hg.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: Make acpid test compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, lvivier@redhat.com, pbonzini@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com, qemu-devel@nongnu.org

On Wed, Aug 30, 2017 at 12:51:23PM +0200, Juan Quintela wrote:
> Cedric Le Goater <clg@kaod.org> wrote:
> > On 08/23/2017 01:53 PM, Dr. David Alan Gilbert wrote:
> >> * Juan Quintela (quintela@redhat.com) wrote:
> >>> Compiler gets confused with the size of the struct, so move form
> >>> g_new0() to g_malloc0().
> >>>
> >>> I *think* that the problem is in gcc (or glib for that matter), but
> >>> the documentation of the g_new0 states that 1sts first argument is an
> >>> struct type, and uint32_t is not an struct type.
> >>>
> >>> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >>> ---
> >>>  tests/vmgenid-test.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
> >>> index 3d5c1c3615..032e1d465a 100644
> >>> --- a/tests/vmgenid-test.c
> >>> +++ b/tests/vmgenid-test.c
> >>> @@ -67,7 +67,7 @@ static uint32_t acpi_find_vgia(void)
> >>>      g_assert_cmpint(tables_nr, >, 0);
> >>>  
> >>>      /* get the addresses of the tables pointed by rsdt */
> >>> -    tables = g_new0(uint32_t, tables_nr);
> >>> +    tables = g_malloc0(sizeof(uint32_t) * tables_nr);
> >> 
> >> I think there's an easier fix for this I think;
> >> try:
> >> 
> >> -    g_assert_cmpint(tables_nr, >, 0);
> >> +    g_assert(tables_nr > 0);
> 
> I liked more the following one.
> 
> 
> >
> > I fixed that one with :
> >
> > @@ -40,7 +40,7 @@ static uint32_t acpi_find_vgia(void)
> >      AcpiRsdpDescriptor rsdp_table;
> >      uint32_t rsdt;
> >      AcpiRsdtDescriptorRev1 rsdt_table;
> > -    int tables_nr;
> > +    uint32_t tables_nr;
> >      uint32_t *tables;
> >      AcpiTableHeader ssdt_table;
> >      VgidTable vgid_table;
> 
> 
> This make things work for me, so moving to this one.

It should be size_t, because its taking the result of a calculation that
is size_t.  You also need to change the assert I mention in my other email.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXUy3-0005SR-0z
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXUy2-0003We-37
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:03:23 -0400
Date: Tue, 18 Jul 2017 17:03:09 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170718160309.GU11927@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-11-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1500385286-21142-11-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 10/10] migration: Use JSON null
 instead of "" to reset parameter to default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

On Tue, Jul 18, 2017 at 03:41:26PM +0200, Markus Armbruster wrote:
> migrate-set-parameters sets migration parameters according to is
> arguments like this:
> 
> * Present means "set the parameter to this value"
> 
> * Absent means "leave the parameter unchanged"
> 
> * Except for parameters tls_creds and tls_hostname, "" means "reset
>   the parameter to its default value
> 
> The first two are perfectly normal: presence of the parameter makes
> the command do something.
> 
> The third one overloads the parameter with a second meaning.  The
> overloading is *implicit*, i.e. it's not visible in the types.  Works
> here, because "" is neither a valid TLS credentials ID, nor a valid
> host name.
> 
> Pressing argument values the schema accepts, but are semantically
> invalid, into service to mean "reset to default" is not general, as
> suitable invalid values need not exist.  I also find it ugly.
> 
> To clean this up, we could add a separate flag argument to ask for
> "reset to default", or add a distinct value to @tls_creds and
> @tls_hostname.  This commit implements the latter: add JSON null to
> the values of @tls_creds and @tls_hostname, deprecate "".
> 
> Because we're so close to the 2.10 freeze, implement it in the
> stupidest way possible: have qmp_migrate_set_parameters() rewrite null
> to "" before anything else can see the null.  The proper way to do it
> would be rewriting "" to null, but that requires fixing up code to
> work with null.  Add TODO comments for that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hmp.c                 |  8 ++++++--
>  migration/migration.c | 18 ++++++++++++++++--
>  qapi-schema.json      | 11 +++++++++--
>  3 files changed, 31 insertions(+), 6 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

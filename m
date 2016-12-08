Received: from eggs.gnu.org ([2001:4830:134:3::10]:37744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEzug-0006Q3-7l
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 09:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEzuc-0007jA-DD
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 09:43:10 -0500
Date: Thu, 8 Dec 2016 15:42:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161208144258.GB11427@noname.str.redhat.com>
References: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
	<20161208135527.GH26641@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161208135527.GH26641@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] iscsi: Add blockdev-add support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, pl@kamp.de, ptoscano@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, qemu-devel@nongnu.org

Am 08.12.2016 um 14:55 hat Daniel P. Berrange geschrieben:
> On Thu, Dec 08, 2016 at 02:23:05PM +0100, Kevin Wolf wrote:
> > This adds blockdev-add support to the iscsi block driver.
> > 
> > Note that this is only compile tested at this point. Jeff is going to
> > take over from here and bring the series to a mergable state.
> > 
> > Kevin Wolf (6):
> >   iscsi: Split URL into individual options
> >   iscsi: Handle -iscsi user/password in bdrv_parse_filename()
> >   iscsi: Add initiator-name option
> >   iscsi: Add header-digest option
> >   iscsi: Add timeout option
> >   iscsi: Add blockdev-add support
> > 
> >  block/iscsi.c        | 342 ++++++++++++++++++++++++++++++---------------------
> >  qapi/block-core.json |  74 ++++++++++-
> >  2 files changed, 272 insertions(+), 144 deletions(-)
> 
> This series works as well as my series does, once you apply this fix
> for the crash bug I mention:
> 
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 6a11cdd..320e56a 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -1524,7 +1524,7 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
>  {
>      QemuOptsList *list;
>      QemuOpts *opts;
> -    const char *user, *initiator_name, *header_digest, *timeout;
> +    const char *user, *initiator_name, *header_digest, *timeout, *password, *password_secret;
>  
>      list = qemu_find_opts("iscsi");
>      if (!list) {
> @@ -1542,10 +1542,14 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
>      user = qemu_opt_get(opts, "user");
>      if (user) {
>          qdict_set_default_str(options, "user", user);
> -        qdict_set_default_str(options, "password",
> -                              qemu_opt_get(opts, "password"));
> -        qdict_set_default_str(options, "password-secret",
> -                              qemu_opt_get(opts, "password-secret"));
> +    }
> +    password = qemu_opt_get(opts, "password");
> +    if (password) {
> +        qdict_set_default_str(options, "password", password);
> +    }
> +    password_secret = qemu_opt_get(opts, "password-secret");
> +    if (password_secret) {
> +        qdict_set_default_str(options, "password-secret", password_secret);
>      }

Looks good to me. Though I would keep these inside the 'if (user)'
block.

The driver silently ignores password/password-secret if user isn't given
(this is how it worked even before this patch). The interesting case
where it makes a difference is if you give one option directly to the
block driver and the other one with -iscsi. I don't think we want to
allow that, both options should come from the same place.

Kevin

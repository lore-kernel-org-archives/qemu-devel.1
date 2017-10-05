Received: from eggs.gnu.org ([2001:4830:134:3::10]:56592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dzyH2-0004OU-NB
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 01:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dzyGz-0002xM-Ku
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 01:00:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dzyGz-0002wD-Bj
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 01:00:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59B1825BAF
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 05:00:35 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20171004025043.3788-1-ehabkost@redhat.com>
	<20171004025043.3788-3-ehabkost@redhat.com>
	<87376zv58m.fsf@dusky.pond.sub.org>
	<20171004122308.GI4760@localhost.localdomain>
	<20171004205727.GC5259@localhost.localdomain>
Date: Thu, 05 Oct 2017 07:00:33 +0200
In-Reply-To: <20171004205727.GC5259@localhost.localdomain> (Eduardo Habkost's
	message of "Wed, 4 Oct 2017 17:57:27 -0300")
Message-ID: <87infugpe6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 2/2] vl: Deprecate auto-loading of
 qemu.conf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, Oct 04, 2017 at 09:23:08AM -0300, Eduardo Habkost wrote:
>> On Wed, Oct 04, 2017 at 07:42:17AM +0200, Markus Armbruster wrote:
>> > Eduardo Habkost <ehabkost@redhat.com> writes:
>> > 
>> > > In case there were options set in the default config file, print
>> > > a warning so users can update their scripts.
>> > >
>> > > If somebody wants to keep the config file as-is, avoid the
>> > > warning and use a command-line that will work in future QEMU
>> > > versions, they can use:
>> > >
>> > >  $QEMU -no-user-config -readconfig /etc/qemu/qemu.conf
>> > >
>> > > I was going to include the suggestion in the warning message, but
>> > > I thought it could make it more confusing.  The suggestion is
>> > > documented in qemu-doc.texi.
>> > >
>> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> > > ---
>> > > Changes v3 -> v4:
>> > > * Use warn_report() instead of error_report("warning: ...")
>> > >   (Eric Blake)
>> > > * Document as a deprecated feature in qemu-doc.texi
>> > > * Update subject line
>> > >   (was: "vl: Print warning when a default config file is loaded")
>> > >
>> > > Changes v2 -> v3:
>> > > * Rebase (no code changes)
>> > > * Commit message update: suggest -no-user-config
>> > > ---
>> > >  vl.c          | 6 ++++++
>> > >  qemu-doc.texi | 8 ++++++++
>> > >  2 files changed, 14 insertions(+)
>> > >
>> > > diff --git a/vl.c b/vl.c
>> > > index 3fed457921..1b0ecdf74e 100644
>> > > --- a/vl.c
>> > > +++ b/vl.c
>> > > @@ -3066,6 +3066,12 @@ static int qemu_read_default_config_file(void)
>> > >          return ret;
>> > >      }
>> > >  
>> > > +    if (ret > 0) {
>> > > +        loc_set_none();
>> > 
>> > Sure we need this here?
>> 
>> IIRC we needed it in the original version, but I don't remember
>> why.  I will check this.
>
> This is the result if we don't clear error location state:
>
>   $ ./x86_64-softmmu/qemu-system-x86_64 -monitor stdio -display none -device foobar
>   qemu-system-x86_64: -device foobar: warning: Future QEMU versions won't load /usr/local/etc/qemu/qemu.conf automatically
>                       ^^^^^^^^^^^^^^
>
> However, it's probably better to do this right after the loop,
> just like we already do in the second option parsing loop:
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> diff --git a/vl.c b/vl.c
> index f9acc17c01..a8fd247d71 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3067,7 +3067,6 @@ static int qemu_read_default_config_file(void)
>      }
>  
>      if (ret > 0) {
> -        loc_set_none();
>          warn_report("Future QEMU versions won't load %s automatically",
>                       CONFIG_QEMU_CONFDIR "/qemu.conf");
>      }
> @@ -3224,6 +3223,11 @@ int main(int argc, char **argv, char **envp)
>              }
>          }
>      }
> +    /*
> +     * Clear error location left behind by the loop.
> +     * Best done right after the loop.  Do not insert code here!
> +     */
> +    loc_set_none();
>  
>      if (userconfig) {
>          if (qemu_read_default_config_file() < 0) {

Hmm, could this hunk be a bug fix?  Consider before the patch:

    qemu_read_default_config_file()
        qemu_read_config_file()
            qemu_config_parse()
                error_report() or error_report_err()

I suspect this uses current location left behind by the loop
inappropriately.  If true, the hunk should be a separate bug fix patch.

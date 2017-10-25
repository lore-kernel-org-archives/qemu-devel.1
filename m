Received: from eggs.gnu.org ([2001:4830:134:3::10]:60232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7Sxf-0005zf-4F
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 17:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7Sxb-0006fn-B0
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 17:11:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e7Sxb-0006eZ-2G
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 17:11:35 -0400
Date: Wed, 25 Oct 2017 22:11:29 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171025211129.GD30132@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171024085853.32615-1-aik@ozlabs.ru>
	<20171024162752.GA21671@redhat.com>
	<ef1eab70-8c55-0d75-e516-16ef6a419d04@ozlabs.ru>
	<20171025065755.GB27237@redhat.com>
	<6b823cd9-ef9d-a704-ed25-91f360018eca@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b823cd9-ef9d-a704-ed25-91f360018eca@ozlabs.ru>
Subject: Re: [Qemu-devel] [RFC PATCH qemu] git-submodule.sh: Do not try
 writing to source directory if not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org

On Wed, Oct 25, 2017 at 07:10:40PM +1100, Alexey Kardashevskiy wrote:
> On 25/10/17 17:57, Daniel P. Berrange wrote:
> > On Wed, Oct 25, 2017 at 12:45:10PM +1100, Alexey Kardashevskiy wrote:
> >> On 25/10/17 03:27, Daniel P. Berrange wrote:
> >>> On Tue, Oct 24, 2017 at 07:58:53PM +1100, Alexey Kardashevskiy wrote:
> >>>> The new git-submodule.sh script writes .git-submodule-status to
> >>>> the source directory every time no matter what. This makes it conditional.
> >>>>
> >>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>> ---
> >>>>
> >>>> I compile out of tree on a remote guest system where I mount the
> >>>> source directory as "readonly" and build directory as "rw" and
> >>>> scripts/git-submodule.sh tries writing to the source directory even when
> >>>> I manually update modules on a host machine which is quite annoying.
> >>>>
> >>>> Is this something acceptable? Or I am missing something here?
> >>>
> >>> How did you update the modules - did you manually run  'git submodule update...'
> >>> or did you use the git-submodule.sh script on your host machine ?
> >>
> >>
> >> I run scripts/git-submodule.sh. Which is not thrilling either as I rather
> >> expect source tree not to be affected in any way when running "make".
> > 
> > Oh, did you pass the list of sub-modules to it when running
> > 
> > eg, ./scripts/git-submodule.sh update ui/keycodemapdb
> > 
> > the list of submodules you need is printed in the configure output summary.
> 
> Sure, otherwise it does nothing.
> 
> 
> > 
> >>> If you run git-submodule.sh on the host, then it should save the status
> >>> file, and then when you run make on the guest system, it should notice
> >>> that you're already updated and never even invoke 'git-submodule.sh update'
> >>
> >>
> >> scripts/git-submodule.sh also tries writing to the source directory (I
> >> should probably have fixed that branch too) but this failure is not fatal
> >> for "make" but makes it want to try "update" and then "make" fails.
> > 
> > This shouldn't have happened in your case though, if you have already run
> > 'git-submodule.sh update ...list of modules...' on the host machine, with
> > the same list of modules that the guest 'configure' printed out.
> 
> It does not matter if I run git-submodule.sh or not - "git-submodule.sh
> status" will try writing to the read only folder anyway and it will fail
> and Makefile's  git_module_status will be set to 1.


Ahhhh, great, now I understand why you're hitting the problem !

> If I do as below (and that's what I should have done as I said), then
> "git-submodule.sh update" is not invoked and we are good. I am not
> reposting it yet as 1) my shell skills are crap (need to delete the temp
> file or rewrite the whole thing not to use temp file or rewrite it in
> python - why do not people use python everywhere?!) 2) I still hope we stop
> doing this from Makefile :)

I agree using a tmpfile is the right fix here.

> 
> 
> 
> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> index d8fbc7e47e..ced00b6cae 100755
> --- a/scripts/git-submodule.sh
> +++ b/scripts/git-submodule.sh
> @@ -23,16 +23,20 @@ then
>      exit 1
>  fi
> 
> +substat_tmp=$(mktemp)
> +
>  case "$command" in
>  status)
>      test -f "$substat" || exit 1
> -    trap "rm -f ${substat}.tmp" EXIT
> -    git submodule status $modules > "${substat}.tmp"
> -    diff "${substat}" "${substat}.tmp" >/dev/null
> +    git submodule status $modules > "$substat_tmp"
> +    diff "${substat_tmp}" "${substat}" || mv "${substat_tmp}" "${substat}"

We shouldn't be overwriting the existing status file during 'status' - only
'update' should overwrite. 'status' should be a no-op query only.

> +    ( rm "${substat_tmp}" 2>/dev/null )
>      exit $?
>      ;;
>  update)
>      git submodule update --init $modules 1>/dev/null 2>&1
> -    git submodule status $modules > "${substat}"
> +    git submodule status $modules > "$substat_tmp"
> +    diff "${substat_tmp}" "${substat}" || mv "${substat_tmp}" "${substat}"
> +    ( rm "${substat_tmp}" 2>/dev/null )
>      ;;
>  esac
> 
> 
> 
> -- 
> Alexey

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

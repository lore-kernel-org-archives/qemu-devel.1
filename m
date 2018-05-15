Received: from eggs.gnu.org ([2001:4830:134:3::10]:36873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fIbzf-0002ZI-LN
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fIbzZ-0004BT-T5
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:36:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fIbzZ-0004BF-Nv
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:35:57 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180515140944.15979-1-danielhb@linux.ibm.com>
	<20180515140944.15979-3-danielhb@linux.ibm.com>
Date: Tue, 15 May 2018 17:35:55 +0200
In-Reply-To: <20180515140944.15979-3-danielhb@linux.ibm.com> (Daniel Henrique
	Barboza's message of "Tue, 15 May 2018 11:09:44 -0300")
Message-ID: <8736ytue1w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 2/2] qga: update guest-suspend-ram and
 guest-suspend-hybrid descriptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, dgilbert@redhat.com

Daniel Henrique Barboza <danielhb@linux.ibm.com> writes:

> This patch updates the descriptions of 'guest-suspend-ram' and
> 'guest-suspend-hybrid' to mention that both commands relies now
> on the existence of 'system_wakeup' and also on the proper support
> for wake up from suspend, retrieved by the 'wakeup-suspend-support'
> attribute of the 'query-target' QMP command.
>
> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.ibm.com>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  qga/qapi-schema.json | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 17884c7c70..e3fb8adfce 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -566,8 +566,11 @@
>  # package installed in the guest.
>  #
>  # IMPORTANT: guest-suspend-ram requires QEMU to support the 'system_wakeup'
> -# command.  Thus, it's *required* to query QEMU for the presence of the
> -# 'system_wakeup' command before issuing guest-suspend-ram.
> +# command and the guest to support wake up from suspend. Thus, it's
> +# *required* to query QEMU for the presence of the 'system_wakeup' command
> +# and to verify that wake up from suspend is enabled by checking the
> +# 'wakeup-suspend-support' flag of 'query-target' QMP command, before issuing
> +# guest-suspend-ram.

Isn't checking for presence of system_wakeup redundant?

When query-target tells us "system_wakeup works" by returning
wakeup-suspend-support: true, we surely have system_wakeup (or else
query-target would be lying to us).

When it returns wakeup-suspend-support: false, it doesn't matter whether
we have system_wakeup.

Unless I'm wrong, we can simplify this to something like

   # IMPORTANT: guest-suspend-ram requires working wakeup support in
   # QEMU.  You *must* check QMP command query-target returns
   # wakeup-suspend-support: true before issuing this command.

>  #
>  # This command does NOT return a response on success. There are two options
>  # to check for success:
> @@ -593,8 +596,11 @@
>  # This command requires the pm-utils package to be installed in the guest.
>  #
>  # IMPORTANT: guest-suspend-hybrid requires QEMU to support the 'system_wakeup'
> -# command.  Thus, it's *required* to query QEMU for the presence of the
> -# 'system_wakeup' command before issuing guest-suspend-hybrid.
> +# command and the guest to support wake up from suspend. Thus, it's
> +# *required* to query QEMU for the presence of the 'system_wakeup' command
> +# and to verify that wake up from suspend is enabled by checking the
> +# 'wakeup-suspend-support' flag of 'query-target' QMP command, before issuing
> +# guest-suspend-hybrid.
>  #
>  # This command does NOT return a response on success. There are two options
>  # to check for success:

Likewise.

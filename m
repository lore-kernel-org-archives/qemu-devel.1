Received: from eggs.gnu.org ([2001:4830:134:3::10]:32777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSLHB-0003Dc-KQ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:18:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSLHA-0007jt-LD
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:18:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gSLHA-0007Yg-Ay
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:18:36 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181109173309.25212-1-danielhb413@gmail.com>
	<20181109173309.25212-3-danielhb413@gmail.com>
Date: Thu, 29 Nov 2018 13:18:29 +0100
In-Reply-To: <20181109173309.25212-3-danielhb413@gmail.com> (Daniel Henrique
	Barboza's message of "Fri, 9 Nov 2018 15:33:08 -0200")
Message-ID: <87lg5c9iwa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.2 v10 2/3] qga: update
 guest-suspend-ram and guest-suspend-hybrid descriptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com, mdroth@linux.vnet.ibm.com, imammedo@redhat.com

Daniel Henrique Barboza <danielhb413@gmail.com> writes:

> This patch updates the descriptions of 'guest-suspend-ram' and
> 'guest-suspend-hybrid' to mention that both commands relies now
> on the proper support for wake up from suspend, retrieved by the
> 'wakeup-suspend-support' attribute of the 'query-current-machine'
> QMP command.
>
> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  qga/qapi-schema.json | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index c6725b3ec8..78a439263e 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -567,9 +567,11 @@
>  # For the best results it's strongly recommended to have the pm-utils
>  # package installed in the guest.
>  #
> -# IMPORTANT: guest-suspend-ram requires QEMU to support the 'system_wakeup'
> -# command.  Thus, it's *required* to query QEMU for the presence of the
> -# 'system_wakeup' command before issuing guest-suspend-ram.
> +# IMPORTANT: guest-suspend-ram requires working wakeup support in
> +# QEMU. You *must* check QMP command query-current-machine returns
> +# wakeup-suspend-support: true before issuing this command. Failure in
> +# doing so can result in a suspended guest that QEMU will not be able to
> +# awaken, forcing the user to power cycle the guest to bring it back.
>  #
>  # This command does NOT return a response on success. There are two options
>  # to check for success:
> @@ -594,9 +596,11 @@
>  #
>  # This command requires the pm-utils package to be installed in the guest.
>  #
> -# IMPORTANT: guest-suspend-hybrid requires QEMU to support the 'system_wakeup'
> -# command.  Thus, it's *required* to query QEMU for the presence of the
> -# 'system_wakeup' command before issuing guest-suspend-hybrid.
> +# IMPORTANT: guest-suspend-hybrid requires working wakeup support in
> +# QEMU. You *must* check QMP command query-current-machine returns
> +# wakeup-suspend-support: true before issuing this command. Failure in
> +# doing so can result in a suspended guest that QEMU will not be able to
> +# awaken, forcing the user to power cycle the guest to bring it back.
>  #
>  # This command does NOT return a response on success. There are two options
>  # to check for success:

Nice improvement.  However, I'd tone down "You *must*" to "You should".
This is just one of many ways to screw up the guest with the guest
agent.  While serious, it's not as bad as compromising the sandbox, or
killing QEMU.

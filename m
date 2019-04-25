Received: from eggs.gnu.org ([209.51.188.92]:49967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hJlOs-0004P5-Ja
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hJlOq-0007RC-Mz
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:55:22 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:46083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1hJlOq-0007R4-Iw
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:55:20 -0400
Received: by mail-qt1-x844.google.com with SMTP id w26so1695836qto.13
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 13:55:20 -0700 (PDT)
References: <20190424004700.12766-1-richardw.yang@linux.intel.com>
	<20190424004700.12766-3-richardw.yang@linux.intel.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <0eb5e5a5-593e-f4a2-7e2d-a9fed481ab6c@gmail.com>
Date: Thu, 25 Apr 2019 17:55:15 -0300
MIME-Version: 1.0
In-Reply-To: <20190424004700.12766-3-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/4] migration/savevm: use
 migration_is_blocked to validate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com



On 4/23/19 9:46 PM, Wei Yang wrote:
> migration_is_blocked() is used in migrate_prepare() and
> save_snapshot(), this is more proper to use this instead of
> qemu_savevm_state_blocked() in qemu_loadvm_state().


migration_is_blocked() does an additional verification:

"if (migration_blockers)"

comparing to what was previously done in qemu_loadvm_state.

I've checked what migration_blockers does and it is a GList used
for callers to block the migration process. This is used via
'migration_add_blocker', from migration.c.

'migration_add_blocker' is called all over the place, most notably
in  _realize() functions  and _open() functions from block.

Thus, I am not sure if this change will impact the use of
qemu_loadvm_state() from load_snapshot() (i.e. can load_snapshot
be called with migration_blockers?). It's better to someone
with a better understanding of this code to comment on that.


DHB



> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>   migration/savevm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 2eea604624..6c61056cde 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2406,7 +2406,7 @@ int qemu_loadvm_state(QEMUFile *f)
>       unsigned int v;
>       int ret;
>   
> -    if (qemu_savevm_state_blocked(&local_err)) {
> +    if (migration_is_blocked(&local_err)) {
>           error_report_err(local_err);
>           return -EINVAL;
>       }

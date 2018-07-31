Received: from eggs.gnu.org ([2001:4830:134:3::10]:39500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fkSq4-0004Wv-Pw
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 07:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fkSq1-0003FZ-Id
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 07:29:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34704 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fkSq1-0003F5-Bs
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 07:29:13 -0400
Date: Tue, 31 Jul 2018 12:29:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180731112906.GG2476@work-vm>
References: <1533026124-6740-1-git-send-email-liq3ea@gmail.com>
	<1533026124-6740-3-git-send-email-liq3ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533026124-6740-3-git-send-email-liq3ea@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Add qmp command for
 migrate_set_max_cpu_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, quintela@redhat.com, eblake@redhat.com, armbru@redhat.com, liqiang02@corp.netease.com, hzliuyingdong@corp.netease.com, qemu-devel@nongnu.org

* Li Qiang (liq3ea@gmail.com) wrote:
> The default max cpu throttle is 99, this is too big that may
> influence the guest loads. Add a qmp to config it can make it
> more flexible.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

This should be done as a migration parameter rather than a new command.
For example, follow the cpu-throttle-increment parameter; and this
should work just like it.

Dave

> ---
>  cpus.c                |  5 +++++
>  include/qom/cpu.h     |  8 ++++++++
>  migration/migration.c | 10 ++++++++++
>  qapi/migration.json   | 13 +++++++++++++
>  4 files changed, 36 insertions(+)
> 
> diff --git a/cpus.c b/cpus.c
> index 6569c73d24..0505477086 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -765,6 +765,11 @@ void cpu_throttle_set(int new_throttle_pct)
>                                         CPU_THROTTLE_TIMESLICE_NS);
>  }
>  
> +void set_cpu_max_throttle(int64_t max_pct)
> +{
> +    throttle_percentage_max = max_pct;
> +}
> +
>  void cpu_throttle_stop(void)
>  {
>      atomic_set(&throttle_percentage, 0);
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index bd796579ee..4328d2e8ad 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -816,6 +816,14 @@ CPUState *cpu_by_arch_id(int64_t id);
>  void cpu_throttle_set(int new_throttle_pct);
>  
>  /**
> + * set_cpu_max_throttle:
> + * @max_pct: the max percent of sleep time. Valid range is 1 to 99.
> + *
> + * Set the max throttle percentage.
> + */
> +void set_cpu_max_throttle(int64_t max_pct);
> +
> +/**
>   * cpu_throttle_stop:
>   *
>   * Stops the vcpu throttling started by cpu_throttle_set.
> diff --git a/migration/migration.c b/migration/migration.c
> index b7d9854bda..9c7a6f7477 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1774,6 +1774,16 @@ void qmp_migrate_set_speed(int64_t value, Error **errp)
>      qmp_migrate_set_parameters(&p, errp);
>  }
>  
> +void qmp_migrate_set_max_cpu_throttle(int64_t value, Error **errp)
> +{
> +    if (value > 99 || value < 1) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, " max cpu throttle",
> +                        "not in 1 between 99");
> +        return;
> +    }
> +    set_cpu_max_throttle(value);
> +}
> +
>  void qmp_migrate_set_downtime(double value, Error **errp)
>  {
>      if (value < 0 || value > MAX_MIGRATE_DOWNTIME_SECONDS) {
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 186e8a7303..2ef3ddfe43 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -997,6 +997,19 @@
>  { 'command': 'migrate_set_speed', 'data': {'value': 'int'} }
>  
>  ##
> +# @migrate_set_max_cpu_throttle:
> +#
> +# Set maximum cpu throttle for migration.
> +#
> +# @value: maximum cpu throttle.
> +#
> +# Returns: nothing on success
> +#
> +# Since: 2.12
> +##
> +{ 'command': 'migrate_set_max_cpu_throttle', 'data': {'value': 'int'} }
> +
> +##
>  # @migrate-set-cache-size:
>  #
>  # Set cache size to be used by XBZRLE migration
> -- 
> 2.11.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

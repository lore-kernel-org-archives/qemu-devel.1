Received: from eggs.gnu.org ([2001:4830:134:3::10]:51577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ez30T-00027e-C7
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ez30S-0000GE-9t
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:24:01 -0400
Date: Thu, 22 Mar 2018 16:23:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180322162341.GC3205@work-vm>
References: <20180322161226.29796-1-lvivier@redhat.com>
	<20180322161226.29796-4-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322161226.29796-4-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] qdict: remove useless cast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Eric Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Markus Armbruster <armbru@redhat.com>

* Laurent Vivier (lvivier@redhat.com) wrote:
> Re-run Coccinelle script scripts/coccinelle/qobject.cocci
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  block/nvme.c | 11 +++++------
>  monitor.c    |  2 +-
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 8bca57aae6..c4f3a7bc94 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -695,12 +695,11 @@ static void nvme_parse_filename(const char *filename, QDict *options,
>          unsigned long ns;
>          const char *slash = strchr(tmp, '/');
>          if (!slash) {
> -            qdict_put(options, NVME_BLOCK_OPT_DEVICE,
> -                      qstring_from_str(tmp));
> +            qdict_put_str(options, NVME_BLOCK_OPT_DEVICE, tmp);
>              return;
>          }
>          device = g_strndup(tmp, slash - tmp);
> -        qdict_put(options, NVME_BLOCK_OPT_DEVICE, qstring_from_str(device));
> +        qdict_put_str(options, NVME_BLOCK_OPT_DEVICE, device);
>          g_free(device);
>          namespace = slash + 1;
>          if (*namespace && qemu_strtoul(namespace, NULL, 10, &ns)) {
> @@ -708,8 +707,8 @@ static void nvme_parse_filename(const char *filename, QDict *options,
>                         namespace);
>              return;
>          }
> -        qdict_put(options, NVME_BLOCK_OPT_NAMESPACE,
> -                  qstring_from_str(*namespace ? namespace : "1"));
> +        qdict_put_str(options, NVME_BLOCK_OPT_NAMESPACE,
> +                      *namespace ? namespace : "1");
>      }
>  }
>  
> @@ -1082,7 +1081,7 @@ static void nvme_refresh_filename(BlockDriverState *bs, QDict *opts)
>                   bs->drv->format_name);
>      }
>  
> -    qdict_put(opts, "driver", qstring_from_str(bs->drv->format_name));
> +    qdict_put_str(opts, "driver", bs->drv->format_name);
>      bs->full_open_options = opts;
>  }
>  
> diff --git a/monitor.c b/monitor.c
> index 6ccd2fc089..6e7667d82f 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4316,7 +4316,7 @@ static QObject *get_qmp_greeting(Monitor *mon)
>              /* Monitors that are not using IOThread won't support OOB */
>              continue;
>          }
> -        qlist_append(cap_list, qstring_from_str(QMPCapability_str(cap)));
> +        qlist_append_str(cap_list, QMPCapability_str(cap));
>      }
>  
>      return qobject_from_jsonf("{'QMP': {'version': %p, 'capabilities': %p}}",

For monitor:

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

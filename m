Received: from eggs.gnu.org ([209.51.188.92]:54411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1guIpr-0006xT-3X
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:21:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1guIpq-0000hf-B1
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:21:59 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190212145415.GD5283@localhost.localdomain>
References: <cover.1547739122.git.berto@igalia.com>
	<2da7b388a740d1f1b7f40e1182fc821f8abb8fbb.1547739122.git.berto@igalia.com>
	<20190212145415.GD5283@localhost.localdomain>
Date: Thu, 14 Feb 2019 16:21:55 +0100
Message-ID: <w51h8d62y5o.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 02/13] block: Freeze the backing chain for
 the duration of the commit job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 12 Feb 2019 03:54:15 PM CET, Kevin Wolf wrote:
>> @@ -336,6 +340,10 @@ void commit_start(const char *job_id, BlockDriverState *bs,
>>          }
>>      }
>>  
>> +    if (bdrv_freeze_backing_chain(commit_top_bs, base, errp) < 0) {
>> +        goto fail;
>> +    }
>
> Don't error paths need to unfreeze after this?

Yes, and while debugging this I realized that the error path is wrong:

    if (commit_top_bs) {
        bdrv_replace_node(commit_top_bs, top, &error_abort);
    }
    job_early_fail(&s->common.job);

Doing bdrv_replace_node() here before job_early_fail() fails with

Unexpected error in bdrv_check_update_perm() at block.c:1920:
Conflicts with use by commit job 'virtio0' as 'intermediate node', which does not allow 'consistent read' on <node-name>
Aborted

I'll write a separate patch for this problem.

Berto

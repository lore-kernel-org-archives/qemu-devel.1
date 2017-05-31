Received: from eggs.gnu.org ([2001:4830:134:3::10]:46025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dG881-0004Aw-Lu
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dG87y-0001hn-HR
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:13:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dG87y-0001hN-AW
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:13:50 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170529131716.94338-1-pasic@linux.vnet.ibm.com> (Halil Pasic's
	message of "Mon, 29 May 2017 15:17:16 +0200")
References: <20170529131716.94338-1-pasic@linux.vnet.ibm.com>
Reply-To: quintela@redhat.com
Date: Wed, 31 May 2017 20:13:47 +0200
Message-ID: <87mv9sc2sk.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x: vmstatify config migration for
 virtio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> Let's vmstatify virtio_ccw_save_config and virtio_ccw_load_config for
> flexibility (extending using subsections) and for fun.
>
> To achieve this we need to hack the config_vector, which is VirtIODevice
> (that is common virtio) state, in the middle of the VirtioCcwDevice state
> representation.  This somewhat ugly, but we have no choice because the
> stream format needs to be preserved.
>
> Almost no changes in behavior. Exception is everything that comes with
> vmstate like extra bookkeeping about what's in the stream, and maybe some
> extra checks and better error reporting.
>
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

> +static void subch_dev_pre_save(void *opaque)
> +{
> +    SubchDev *s = opaque;
> +
> +    /* Prepare remote_schid for save */
> +    s->migrated_schid = s->schid;
> +}
> +
> +static int subch_dev_post_load(void *opaque, int version_id)
> +{
> +
> +    SubchDev *s = opaque;
> +
> +    /* Re-assign the subchannel to remote_schid if necessary */
> +    if (s->migrated_schid != s->schid) {
> +        if (css_find_subch(true, s->cssid, s->ssid, s->schid) == s) {

I am assuming this is somehow similar to
   old_s = channel_subsys.css[s->cssid]->sch_set[s->ssid]->sch[old_schid];



> -    qemu_put_be32(f, s->curr_status.pmcw.intparm);
> -    qemu_put_be16(f, s->curr_status.pmcw.flags);
> -    qemu_put_be16(f, s->curr_status.pmcw.devno);
> -    qemu_put_byte(f, s->curr_status.pmcw.lpm);
> -    qemu_put_byte(f, s->curr_status.pmcw.pnom);
> -    qemu_put_byte(f, s->curr_status.pmcw.lpum);
> -    qemu_put_byte(f, s->curr_status.pmcw.pim);
> -    qemu_put_be16(f, s->curr_status.pmcw.mbi);
> -    qemu_put_byte(f, s->curr_status.pmcw.pom);
> -    qemu_put_byte(f, s->curr_status.pmcw.pam);

I hope it somehow makes sense, I am having trouble following that you
have fields named: pim, pam, pom, pnom, lpm, lpum, mda, mba ..... looks
like hell for reviewing O:-)

And I thought that x86 was weird because it used all three letters
acronyms

O:-)

Later, Juan.

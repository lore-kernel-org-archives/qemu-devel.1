Received: from eggs.gnu.org ([2001:4830:134:3::10]:40984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dQz4r-0006rT-Jl
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dQz4n-0007ad-Lx
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:47:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dQz4n-0007YM-BU
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:47:25 -0400
References: <1498829133-20598-1-git-send-email-mihajlov@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5566d3c2-f791-eab2-cafa-795c96739d8c@redhat.com>
Date: Fri, 30 Jun 2017 18:47:15 +0200
MIME-Version: 1.0
In-Reply-To: <1498829133-20598-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390: return unavailable features via
 query-cpu-definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, Eduardo Habkost <ehabkost@redhat.com>

On 30.06.2017 15:25, Viktor Mihajlovski wrote:
> The response for query-cpu-definitions didn't include the
> unavailable-features field, which is used by libvirt to figure
> out whether a certain cpu model is usable on the host.
> 
> The unavailable features are now computed by obtaining the host CPU
> model and comparing its feature bitmap with the feature bitmaps of
> the known CPU models.
> 
> I.e. the output of virsh domcapabilities would change from
>  ...
>      <mode name='custom' supported='yes'>
>       <model usable='unknown'>z10EC-base</model>
>       <model usable='unknown'>z9EC-base</model>
>       <model usable='unknown'>z196.2-base</model>
>       <model usable='unknown'>z900-base</model>
>       <model usable='unknown'>z990</model>
>  ...
> to
>  ...
>      <mode name='custom' supported='yes'>
>       <model usable='yes'>z10EC-base</model>
>       <model usable='yes'>z9EC-base</model>
>       <model usable='no'>z196.2-base</model>
>       <model usable='yes'>z900-base</model>
>       <model usable='yes'>z990</model>
>  ...
> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> ---
>  target/s390x/cpu_models.c | 51 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 46 insertions(+), 5 deletions(-)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 63903c2..dc3371f 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -283,14 +283,43 @@ void s390_cpu_list(FILE *f, fprintf_function print)
>      }
>  }
>  
> +static S390CPUModel *get_max_cpu_model(Error **errp);
> +
>  #ifndef CONFIG_USER_ONLY
> +static void list_add_feat(const char *name, void *opaque);
> +
> +static void check_unavailable_features(const S390CPUModel *max_model,
> +                                       const S390CPUModel *model,
> +                                       strList **unavailable)
> +{
> +    S390FeatBitmap missing;
> +
> +    /* detect missing features if any to properly report them */
> +    bitmap_andnot(missing, model->features, max_model->features,
> +                  S390_FEAT_MAX);
> +    if (!bitmap_empty(missing, S390_FEAT_MAX)) {
> +        s390_feat_bitmap_to_ascii(missing,
> +                                  unavailable,
> +                                  list_add_feat);

I remember discussing this with Eduardo when he introduced this.

There is one additional case to handle here that might turn a CPU model
not runnable. This can happen when trying to run a new CPU model on an
old host, where the features are not the problem, but the model itself.
E.g. running a GA2 version on a GA1 is not allowed. But this can happen
more generally also between hardware generations.

Therefore, whenever the model is never than the host model, we have to
add here the special property "type" as missing feature. The
documentation partly coveres what we had in mind.

qapi-schema.json:
# @unavailable-features is a list of QOM property names that

# represent CPU model attributes that prevent the CPU from running.

# If the QOM property is read-only, that means there's no known

# way to make the CPU model run in the current host. Implementations

# that choose not to provide specific information return the

# property name "type".

We discussed that "type" should always be added if there is no way to
make the model runnable (by simply removing features).

See check_compatibility() for details. For these cases, add "type" to
the list. (you might be able to extend check_compatibility(), making
e.g. the *errp and *unavailable parameters optional).

-- 

Thanks,

David

Received: from eggs.gnu.org ([209.51.188.92]:48476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1goYSA-0004kZ-FY
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1goYS9-0001Rv-Ay
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:49:46 -0500
References: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
	<20190127090306.30826-3-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.9999.1901271251060.35973@zero.eik.bme.hu>
	<3dc12858-4254-9da1-7eb2-309948d0d376@ilande.co.uk>
	<5ea37d08-91f6-33cc-b220-f1a96796d794@linaro.org>
	<897875e0-fc56-c280-0cd0-c7e0dac04fa1@ilande.co.uk>
	<3f43ac97-26d0-98b3-a8b4-8102acb73457@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3b76b534-9801-51ce-b72e-8fe6fdd141c9@ilande.co.uk>
Date: Tue, 29 Jan 2019 18:49:18 +0000
MIME-Version: 1.0
In-Reply-To: <3f43ac97-26d0-98b3-a8b4-8102acb73457@linaro.org>
Content-Type: multipart/mixed; boundary="------------2021652B037BF8EB16EE9BE1"
Content-Language: en-GB
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 2/8] target/ppc: rework
 vmrg{l, h}{b, h, w} instructions to use Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

This is a multi-part message in MIME format.
--------------2021652B037BF8EB16EE9BE1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 27/01/2019 18:07, Richard Henderson wrote:

> On 1/27/19 9:45 AM, Mark Cave-Ayland wrote:
>>> I would expect the i < n/2 loop to be faster, because the assignments are
>>> unconditional.  FWIW.
>>
>> Do you have any idea as to how much faster? Is it something that would show
>> up as significant within the context of QEMU?
> 
> I don't have any numbers on that, no.
> 
>> As well as eliminating the HI_IDX/LO_IDX constants I do find the updated
>> version much easier to read, so I would prefer to keep it if possible.
>> What about unrolling the loop into 2 separate ones...
> 
> I doubt that would be helpful.
> 
> I would think that
> 
> #define VMRG_DO(name, access, ofs)
> ...
>     int i, half = ARRAY_SIZE(r->access(0)) / 2;
> ...
>     for (i = 0; i < half; i++) {
>         result.access(2 * i + 0) = a->access(i + ofs);
>         result.access(2 * i + 1) = b->access(i + ofs);
>     }
> 
> where OFS = 0 for HI and half for LO is best.  I find it quite readable, and it
> avoids duplicating code between LO and HI as you're currently doing.

Attached is my test program which benchmarks the different approaches across
0x8000000 iterations and gives the following sample output here on an i7 when
compiled with gcc -O2:

$ ./mcatest
Benchmark 1 - existing merge high
Elapsed time: 1434735 us

Benchmark 2 - v3 merge high
Elapsed time: 2603553 us

Benchmark 3 - 2 loops merge high
Elapsed time: 2395434 us

Benchmark 4 - Richard's merge high
Elapsed time: 1318369 us


These indicate that the proposed v3 merge algorithm is nearly 50% slower than the
existing implementation - it wasn't something noticeable during emulation, but in a
benchmark situation the additional overhead is clearly visible.

TLDR: after playing around with the different approaches, Richard's proposed
algorithm is the fastest, and is actually slightly quicker than the current
implementation. Please go to the foyer after class where you can collect your prize :)

On this basis I'll redo v3 using Richard's algorithm and post a v4 later assuming
that it passes my local tests again.


ATB,

Mark.

--------------2021652B037BF8EB16EE9BE1
Content-Type: text/x-csrc;
 name="mcatest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mcatest.c"

#include <stdio.h>
#include <stdint.h>
#include <float.h>
#include <sys/time.h>

/* VSX/Altivec registers (128 bits) */
typedef union _ppc_vsr_t {
    uint8_t u8[16];
    uint16_t u16[8];
    uint32_t u32[4];
    uint64_t u64[2];
    int8_t s8[16];
    int16_t s16[8];
    int32_t s32[4];
    int64_t s64[2];
    float f32[4];
    double f64[2];
} ppc_vsr_t;

typedef ppc_vsr_t ppc_avr_t;

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
#define IS_LITTLE_ENDIAN (1 == *(unsigned char *)&(const int){1})

#if defined(IS_LITTLE_ENDIAN)
#define HI_IDX 1
#define LO_IDX 0
#define VsrB(i) u8[15 - (i)]
#else
#define HI_IDX 0
#define LO_IDX 1
#define VsrB(i) u8[i]
#endif

#define ITERATIONS 0x8000000

void benchmark1(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
{
    /* Existing algorithm */
    ppc_avr_t result;
    int i;
    size_t n_elems = ARRAY_SIZE(r->u8);

    for (i = 0; i < n_elems / 2; i++) {
        result.u8[i*2+HI_IDX] = a->u8[i];
        result.u8[i*2+LO_IDX] = b->u8[i];
    }
    *r = result;    
}

void benchmark2(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
{
    /* v3 patchset algorithm */
    ppc_avr_t result;
    int i;

    for (i = 0; i < ARRAY_SIZE(r->u8); i++) {
        result.VsrB(i) = (i & 1) ? b->VsrB(i >> 1)
                                 : a->VsrB(i >> 1);
    }
    *r = result;
}

void benchmark3(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
{
    /* Split loop into 2 halves */
    ppc_avr_t result;
    int i;

    for (i = 0; i < ARRAY_SIZE(r->u8); i+=2) {
        result.VsrB(i) = a->VsrB(i >> 1);
    }

    for (i = 1; i < ARRAY_SIZE(r->u8); i+=2) {
        result.VsrB(i) = b->VsrB(i >> 1);
    }
    *r = result;
}

void benchmark4(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
{
    /* Richard's merge high */
    ppc_avr_t result;    
    int i;
    int half = ARRAY_SIZE(r->u8) / 2;
    int ofs = 0;

    for (i = 0; i < half; i++) {
        result.VsrB(i * 2 + 0) = a->VsrB(i + ofs);
        result.VsrB(i * 2 + 1) = b->VsrB(i + ofs);
    }
    *r = result;
}

int elapsed_time(struct timeval *st, struct timeval *et)
{
    return ((et->tv_sec - st->tv_sec) * 1000000) + (et->tv_usec - st->tv_usec);    
}

int main(int argc, char *argv[]) 
{
    ppc_avr_t a, b, r;
    int i;
    struct timeval start_time, end_time;

    printf("Benchmark 1 - existing merge high\n");
    gettimeofday(&start_time, NULL);

    for (i = 0; i < ITERATIONS; i++) {
        benchmark1(&r, &a, &b);
    }
    
    gettimeofday(&end_time ,NULL);
    printf("Elapsed time: %d us\n\n", elapsed_time(&start_time, &end_time));
    

    printf("Benchmark 2 - v3 merge high\n");
    gettimeofday(&start_time, NULL);

    for (i = 0; i < ITERATIONS; i++) {
        benchmark2(&r, &a, &b);
    }
    
    gettimeofday(&end_time ,NULL);
    printf("Elapsed time: %d us\n\n", elapsed_time(&start_time, &end_time));
    

    printf("Benchmark 3 - 2 loops merge high\n");
    gettimeofday(&start_time, NULL);

    for (i = 0; i < ITERATIONS; i++) {
        benchmark3(&r, &a, &b);
    }

    gettimeofday(&end_time ,NULL);
    printf("Elapsed time: %d us\n\n", elapsed_time(&start_time, &end_time));


    printf("Benchmark 4 - Richard's merge high\n");
    gettimeofday(&start_time, NULL);

    for (i = 0; i < ITERATIONS; i++) {
        benchmark4(&r, &a, &b);
    }
    
    gettimeofday(&end_time ,NULL);
    printf("Elapsed time: %d us\n\n", elapsed_time(&start_time, &end_time));
}

--------------2021652B037BF8EB16EE9BE1--
